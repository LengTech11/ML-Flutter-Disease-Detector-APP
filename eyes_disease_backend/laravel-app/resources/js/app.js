import './bootstrap';

import Alpine from 'alpinejs';

window.Alpine = Alpine;

Alpine.start();

<<<<<<< HEAD
import {
    Modal,
    Ripple,
    initTWE,
  } from "tw-elements";

  initTWE({ Modal, Ripple });
=======
import ApexCharts from 'apexcharts';

if (document.getElementById('main-chart')) {
	const options = {
		chart: {
			height: 420,
			type: 'area',
			fontFamily: 'Inter, sans-serif',
			foreColor: '#6B7280',
			toolbar: {
				show: false
			}
		},
		fill: {
			type: 'solid',
			opacity: 0.3,
		},
		dataLabels: {
			enabled: false
		},
		tooltip: {
			style: {
				fontSize: '14px',
				fontFamily: 'Inter, sans-serif',
			},
		},
		grid: {
			show: false,
		},
		series: [
			{
				name: 'Revenue',
				data: [6550, 6218, 6156, 6526, 6356, 6256, 6356],
				color: '#0694a2'
			},
		],
		xaxis: {
			categories: ['01 Feb', '02 Feb', '03 Feb', '04 Feb', '05 Feb', '06 Feb', '07 Feb'],
			labels: {
				style: {
					colors: ['#6B7280'],
					fontSize: '14px',
					fontWeight: 500,
				},
			},
			axisBorder: {
				color: '#F3F4F6',
			},
			axisTicks: {
				color: '#F3F4F6',
			}
		},
		yaxis: {
			labels: {
				style: {
					colors: ['#6B7280'],
					fontSize: '14px',
					fontWeight: 500,
				},
				formatter: function (value) {
					return '$' + value;
				}
			},
		},
		responsive: [
			{
				breakpoint: 1024,
				options: {
					xaxis: {
						labels: {
							show: false
						}
					}
				}
			}
		]
	};

	const chart = new ApexCharts(document.getElementById('main-chart'), options)
	chart.render();
}
>>>>>>> 9ba4be2ef00d78ffe045e9395ffb5c965395adda


