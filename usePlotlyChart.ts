import { ref, onMounted, nextTick } from 'vue'

export const usePlotlyChart = () => {
  const isPlotlyLoaded = ref(false)

  // Load Plotly library
  const loadPlotly = async () => {
    if (typeof window !== 'undefined' && !(window as any).Plotly) {
      return new Promise((resolve) => {
        const script = document.createElement('script')
        script.src = 'https://cdn.plot.ly/plotly-latest.min.js'
        script.onload = () => {
          isPlotlyLoaded.value = true
          resolve(true)
        }
        document.head.appendChild(script)
      })
    } else {
      isPlotlyLoaded.value = true
      return true
    }
  }

  // Render a chart
  const renderChart = async (
    elementId: string,
    data: any[],
    layout: any,
    config?: any
  ) => {
    await loadPlotly()
    await nextTick()

    if (typeof window !== 'undefined' && (window as any).Plotly) {
      const element = document.getElementById(elementId)
      if (element) {
        ;(window as any).Plotly.newPlot(
          elementId,
          data,
          layout,
          config || { responsive: true }
        )
      }
    }
  }

  // Update chart data
  const updateChart = async (elementId: string, data: any[], layout?: any) => {
    if (typeof window !== 'undefined' && (window as any).Plotly) {
      ;(window as any).Plotly.react(elementId, data, layout || {})
    }
  }

  return {
    isPlotlyLoaded,
    loadPlotly,
    renderChart,
    updateChart,
  }
}
