window.draw_graphDay = -> 
    Chart.defaults.global.defaultFontColor = 'rgb(255,255,255)';
    ctx = document.getElementById("myChartDay").getContext('2d')
    myChartDay = new Chart(ctx, {
        type: 'doughnut',
        data: {
            labels: ["Anger", "Contempt", "Disgust", "Fear", "Happiness", "Neutral", "Sadness", "Surprise"],
            datasets: [{
                data: gon.chartData,
                backgroundColor: [
                    'rgb(217,70,56)',
                    'rgb(235,139,47)',
                    'rgb(126,70,153)',
                    'rgb(26,130,78)',
                    'rgb(238,201,55)',
                    'rgb(178,178,178)',
                    'rgb(57,97,174)',
                    'rgb(3,159,217)'
                ],
                borderColor: [
                    'rgb(217,70,56)',
                    'rgb(235,139,47)',
                    'rgb(126,70,153)',
                    'rgb(26,130,78)',
                    'rgb(238,201,55)',
                    'rgb(178,178,178)',
                    'rgb(57,97,174)',
                    'rgb(3,159,217)'
                ],
                borderWidth: 1
            }]
        },
        options: {
        }
    });