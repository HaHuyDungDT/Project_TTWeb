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
			dataType: 'json', // Thêm dataType để jQuery tự parse JSON
			success: function (data) {
				// Cập nhật số lượng cart với totalItems thay vì message
				$('#cart-quantity').text(data.totalItems);

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
			error: function (xhr, status, error) {
				let message = "Có lỗi xảy ra!"; // Default message

				try {
					// Parse JSON response để lấy error message
					const response = JSON.parse(xhr.responseText);
					if (response.error) {
						message = response.error;
					}
				} catch (e) {
					// Nếu không parse được JSON, sử dụng responseText hoặc default message
					message = xhr.responseText || "Có lỗi xảy ra!";
				}

				Toastify({
					text: message,
					duration: 3000,
					newWindow: true,
					close: true,
					gravity: "top",
					position: "right",
					stopOnFocus: true,
					style: {
						background: "#D10024",
					},
					onClick: function(){}
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
		let fromDistrictID = 3695;
		let fromWard = "90737";
		let toDistrictID = parseInt($('#district-select').val());
		let toWard = $(this).val();

		// Bước 1: Lấy service_id
		$.ajax({
			url: "https://online-gateway.ghn.vn/shiip/public-api/v2/shipping-order/available-services",
			type: "POST",
			headers: {
				"token": "7e2513c5-ed99-11ee-983e-5a49fc0dd8ec"
			},
			contentType: "application/json",
			data: JSON.stringify({
				shop_id: 4982538,
				from_district: fromDistrictID,
				to_district: toDistrictID
			}),
			success: function (res) {
				if (res.code === 200 && res.data.length > 0) {
					let serviceId = res.data[0].service_id;

					// Bước 2: Gọi API lấy leadtime
					$.ajax({
						url: "https://online-gateway.ghn.vn/shiip/public-api/v2/shipping-order/leadtime",
						type: "POST",
						headers: {
							"token": "7e2513c5-ed99-11ee-983e-5a49fc0dd8ec"
						},
						contentType: "application/json",
						data: JSON.stringify({
							from_district_id: fromDistrictID,
							from_ward_code: fromWard,
							to_district_id: toDistrictID,
							to_ward_code: toWard,
							service_id: serviceId
						}),
						success: function (res) {
							if (res.code === 200) {
								let timestamp = res.data.leadtime;
								let date = new Date(timestamp * 1000); // Đổi từ UNIX timestamp sang ngày
								let formattedDate = date.toLocaleDateString('vi-VN', {
									weekday: 'long',
									year: 'numeric',
									month: 'long',
									day: 'numeric'
								});
								$('#estimated-delivery-time').html('Dự kiến giao hàng: ' + formattedDate);
							} else {
								$('#estimated-delivery-time').html('<i>Không thể tính toán thời gian giao hàng</i>');
							}
						},
						error: function(error) {
							console.error("Error getting leadtime:", error);
							$('#estimated-delivery-time').html('<i>Không thể tính toán thời gian giao hàng</i>');
						}
					});
				} else {
					$('#estimated-delivery-time').html('<i>Không có dịch vụ vận chuyển đến địa chỉ này</i>');
				}
			},
			error: function(error) {
				console.error("Error getting available services:", error);
				$('#estimated-delivery-time').html('<i>Không thể tính toán thời gian giao hàng</i>');
			}
		});
	});

	$('#province-select').select2();
	$('#district-select').select2();
	$('#ward-select').select2();
});

// Star Rating Interaction
$(document).ready(function() {
    $('.star-rating label').hover(
        function() {
            $(this).prevAll('label').addClass('hover');
        },
        function() {
            $(this).prevAll('label').removeClass('hover');
        }
    );

    $('.star-rating input').change(function() {
        var rating = $(this).val();
        $('.star-rating label').removeClass('selected');
        $(this).next('label').addClass('selected').prevAll('label').addClass('selected');
    });
});


