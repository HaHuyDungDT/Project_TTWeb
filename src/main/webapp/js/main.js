(function($) {
	"use strict"

	// Mobile Nav toggle
	$('.menu-toggle > a').on('click', function (e) {
		e.preventDefault();
		$('#responsive-nav').toggleClass('active');
	})

	// Fix cart dropdown from closing
	$('.cart-dropdown').on('click', function (e) {
		e.stopPropagation();
	});

	/////////////////////////////////////////

	// Products Slick
	$('.products-slick').each(function() {
		var $this = $(this),
				$nav = $this.attr('data-nav');

		$this.slick({
			slidesToShow: 4,
			slidesToScroll: 1,
			autoplay: true,
			infinite: true,
			speed: 300,
			dots: false,
			arrows: true,
			appendArrows: $nav ? $nav : false,
			responsive: [{
	        breakpoint: 991,
	        settings: {
	          slidesToShow: 2,
	          slidesToScroll: 1,
	        }
	      },
	      {
	        breakpoint: 480,
	        settings: {
	          slidesToShow: 1,
	          slidesToScroll: 1,
	        }
	      },
	    ]
		});
	});

	// Products Widget Slick
	$('.products-widget-slick').each(function() {
		var $this = $(this),
				$nav = $this.attr('data-nav');

		$this.slick({
			infinite: true,
			autoplay: true,
			speed: 300,
			dots: false,
			arrows: true,
			appendArrows: $nav ? $nav : false,
		});
	});

	/////////////////////////////////////////

	// Product Main img Slick
	$('#product-main-img').slick({
    infinite: true,
    speed: 300,
    dots: false,
    arrows: true,
    fade: true,
    asNavFor: '#product-imgs',
  });

	// Product imgs Slick
  $('#product-imgs').slick({
    slidesToShow: 3,
    slidesToScroll: 1,
    arrows: true,
    centerMode: true,
    focusOnSelect: true,
		centerPadding: 0,
		vertical: true,
    asNavFor: '#product-main-img',
		responsive: [{
        breakpoint: 991,
        settings: {
					vertical: false,
					arrows: false,
					dots: true,
        }
      },
    ]
  });

	// Product img zoom
	var zoomMainProduct = document.getElementById('product-main-img');
	if (zoomMainProduct) {
		$('#product-main-img .product-preview').zoom();
	}

	/////////////////////////////////////////

	// Input number
	$('.input-number').each(function() {
		var $this = $(this),
		$input = $this.find('input[type="number"]'),
		up = $this.find('.qty-up'),
		down = $this.find('.qty-down');

		down.on('click', function () {
			var value = parseInt($input.val()) - 1;
			value = value < 1 ? 1 : value;
			$input.val(value);
			$input.change();
			updatePriceSlider($this , value)
		})

		up.on('click', function () {
			var value = parseInt($input.val()) + 1;
			$input.val(value);
			$input.change();
			updatePriceSlider($this , value)
		})
	});

	var priceInputMax = document.getElementById('price-max'),
			priceInputMin = document.getElementById('price-min');

	function updatePriceSlider(elem , value) {
		if ( elem.hasClass('price-min') ) {
			console.log('min')
			priceSlider.noUiSlider.set([value, null]);
		} else if ( elem.hasClass('price-max')) {
			console.log('max')
			priceSlider.noUiSlider.set([null, value]);
		}
	}

	// Price Slider
	var priceSlider = document.getElementById('price-slider');
	if (priceSlider) {
		noUiSlider.create(priceSlider, {
			start: [1, 999],
			connect: true,
			step: 1,
			range: {
				'min': 1,
				'max': 999
			}
		});

		priceSlider.noUiSlider.on('update', function( values, handle ) {
			var value = values[handle];
			handle ? priceInputMax.value = value : priceInputMin.value = value
		});
	}

})(jQuery);
$(document).ready(function () {
	$('.add-to-cart-btn').click(function () {
		const productId = $(this).data('product');
		$.ajax({
			url: 'add-cart',
			type: 'post',
			data: {
				productId: productId,
			},
			success: function (data) {
				$('#cart-quantity').text(data.message);
				Toastify({
					text: data.status,
					duration: 3000,
					newWindow: true,
					close: true,
					gravity: "top",
					position: "right",
					stopOnFocus: true,
					style: {
						background: "green",
					},
					onClick: function(){}
				}).showToast();
			},
			error: function (data) {
				const message = data.responseText;

				Toastify({
					text: message,
					duration: 3000,
					newWindow: true,
					close: true,
					gravity: "top", // `top` or `bottom`
					position: "right", // `left`, `center` or `right`
					stopOnFocus: true, // Prevents dismissing of toast on hover
					style: {
						background: "#D10024",
					},
					onClick: function(){} // Callback after click
				}).showToast();
			}
		});
	});
});
$(document).ready(function () {
	$.ajax({
		url: "https://online-gateway.ghn.vn/shiip/public-api/master-data/province", type: "GET", headers: {
			"Token": "7e2513c5-ed99-11ee-983e-5a49fc0dd8ec"
		}, success: function (response) {
			if (response.code === 200) {
				var provinces = response.data;
				var provinceSelect = $('#province-select');
				provinces.forEach(function (province) {
					provinceSelect.append('<option value="' + province.ProvinceID + '">' + province.ProvinceName + '</option>');
				});
			} else {
				console.error("Error fetching provinces", response.message);
			}
		}, error: function (error) {
			console.error("Error fetching provinces", error);
		}
	});
	/*Khi tỉnh thành được chọn thì quận huyện cập nhật theo tỉnh thành đó*/
	$('#province-select').change(function () {
		var provinceID = $(this).val();
		if (provinceID != null) {
			$('#district-select').empty().append('<option value="">--Chọn Quận Huyện--</option>');

			$.ajax({
				url: "https://online-gateway.ghn.vn/shiip/public-api/master-data/district", type: "GET", headers: {
					"Token": "7e2513c5-ed99-11ee-983e-5a49fc0dd8ec"
				}, data: {"province_id": provinceID}, success: function (response) {
					if (response.code === 200) {
						var districts = response.data;
						var districtSelect = $('#district-select');
						districts.forEach(function (district) {
							districtSelect.append('<option value="' + district.DistrictID + '">' + district.DistrictName + '</option>');
						});
					} else {
						console.error("Error fetching districts", response.message);
					}
				}, error: function (error) {
					console.error("Error fetching districts", error);
				}
			});
		} else {
			$('#district-select').empty().append('<option value="">--Chọn Quận Huyện--</option>');
		}
	});
	/*Khi quận huyện được chọn thì phường xã sẽ câpj nhật theo quận huyện đó*/
	$('#district-select').change(function () {
		var districtID = $(this).val();
		if (districtID) {
			$('#ward-select').empty().append('<option value="">--Chọn Phường xã--</option>');
			$.ajax({
				url: "https://online-gateway.ghn.vn/shiip/public-api/master-data/ward", type: "GET", headers: {
					"Token": "7e2513c5-ed99-11ee-983e-5a49fc0dd8ec" // Thay thế bằng token thực tế của bạn
				}, data: {"district_id": districtID},
				success: function (response) {
					if (response.code === 200) {
						var wards = response.data;
						var wardSelect = $('#ward-select');
						wards.forEach(function (ward) {
							wardSelect.append('<option value="' + ward.WardCode + '">' + ward.WardName + '</option>');
						});
					} else {
						console.error("Error fetching wards", response.message);
					}
				}, error: function (error) {
					console.error("Error fetching wards", error);
				}
			});
		} else {
			$('#ward-select').empty().append('<option value="">--Chọn Phường/Xã--</option>');
		}
	});
	/*Khi phườg xã thay đổi thì giá tiền sẽ cập nhật*/
	$('#ward-select').change(function () {
		let fromProvinceID = 202;
		let fromDistrictID = 3695;
		let fromWard = "90737";
		let toProvinceId = parseInt($('#province-select').val());
		let toDistrictID = parseInt($('#district-select').val());
		let toWard = $(this).val();
		$.ajax({
			url: `https://online-gateway.ghn.vn/shiip/public-api/v2/shipping-order/fee?from_province_id=202&from_district_id=3695&from_ward_code=90737&to_province_id=${toProvinceId}&to_district_id=${toDistrictID}&to_ward_code=${toWard}&service_type_id=2&weight=500`,
			type: "GET",
			headers: {
				"token": "7e2513c5-ed99-11ee-983e-5a49fc0dd8ec",
				"shop_id": "4982538"
			},
			success: function (response) {
				if (response.code === 200) {
					let formattedFee = new Intl.NumberFormat('vi-VN', {
						style: 'currency',
						currency: 'VND'
					}).format(response.data.total);
					$('#formattedPrice').html(formattedFee);
				} else {
					console.error("Error calculating fee", response.message);
					$('#fee-delivery').html('<strong>Success nhưng lỗi</strong>');
				}
			},
			error: function (error) {
				console.log("Error calculating fee", error);
				$('#fee-delivery').html('<strong>Lỗi</strong>');
			}
		});
	});

	$('#province-select').select2();
	$('#district-select').select2();
	$('#ward-select').select2();
});


