import { InertiaLinkProps } from '@inertiajs/vue3';
import { clsx, type ClassValue } from 'clsx';
import { twMerge } from 'tailwind-merge';

export function cn(...inputs: ClassValue[]) {
    return twMerge(clsx(inputs));
}

export function urlIsActive(
    urlToCheck: NonNullable<InertiaLinkProps['href']>,
    currentUrl: string,
) {
    return toUrl(urlToCheck) === currentUrl;
}

export function toUrl(href: NonNullable<InertiaLinkProps['href']>) {
    return typeof href === 'string' ? href : href?.url;
}

function normalizeHexColor(color: string) {
    const trimmed = color.trim();
    if (!trimmed.startsWith('#')) return null;

    const hex = trimmed.slice(1);
    if (hex.length === 3) {
        const expanded = hex
            .split('')
            .map((char) => char + char)
            .join('');
        return expanded;
    }

    if (hex.length === 6) {
        return hex;
    }

    return null;
}

function parseRgbValues(color: string) {
    const match = color.trim().match(/^rgba?\(([^)]+)\)$/i);
    if (!match) return null;

    const parts = match[1].split(',').map((part) => part.trim());
    if (parts.length < 3) return null;

    const r = Number(parts[0]);
    const g = Number(parts[1]);
    const b = Number(parts[2]);

    if ([r, g, b].some((value) => Number.isNaN(value))) return null;

    return { r, g, b };
}

function parseColorToRgb(color: string) {
    const normalizedHex = normalizeHexColor(color);
    if (normalizedHex) {
        return {
            r: parseInt(normalizedHex.slice(0, 2), 16),
            g: parseInt(normalizedHex.slice(2, 4), 16),
            b: parseInt(normalizedHex.slice(4, 6), 16),
        };
    }

    return parseRgbValues(color);
}

function getRelativeLuminance(r: number, g: number, b: number) {
    const toLinear = (value: number) => {
        const normalized = value / 255;
        return normalized <= 0.03928
            ? normalized / 12.92
            : ((normalized + 0.055) / 1.055) ** 2.4;
    };

    const red = toLinear(r);
    const green = toLinear(g);
    const blue = toLinear(b);

    return 0.2126 * red + 0.7152 * green + 0.0722 * blue;
}

export function getContrastingTextColor(
    backgroundColor: string,
    darkText = '#1f150c',
    lightText = '#f5f3ed',
) {
    const rgb = parseColorToRgb(backgroundColor);
    if (!rgb) return lightText;

    const luminance = getRelativeLuminance(rgb.r, rgb.g, rgb.b);
    return luminance > 0.5 ? darkText : lightText;
}
