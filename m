Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795662820;
	b=tRuR2NhDtfq/35AaGkr3jmHw6VcRhrngUB0581Mu3583/FJtDduLrDaSZl+wLhtnzm8c
	 u8whpvetw8++hm02LNqwW6Yj/8+nmDbb4MOaoRGR4ZmQtYlj+vURNdAf8IVHUXD24chNK
	 V9o1oYb3cNYccHbST+Po7AtqCxKQRYKjIQzDWlZPLAu8XKyU8mZTh95Jre5+SimX5cXqO
	 xC4KPVV+ucLy8mf++IFcF3xxc3ZKbccA4B/EtNh9EoXp5TwtRFUXEN93auTyMyUeFgMgQ
	 zZ5EOqyteZ8B2rUs3EXUiZyoGLRbFht+5Abd8hc8SfZyhB2H52RzCWJ4UvGqgAzrOug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795662820;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2Ib8aYZITDo/ZPmpEFTS6qhqZypmgy7XDQl+C7k59bg=;
	b=bAPNQvmwlAd/beP0GoBkTGnK56Kmrf9DH7QpOS+CGDaPDtNQXKUd00S5gS0vhRpic0/f
	 BLjM3D3vSSqYQRF1Q13wRBsuoxGkkSxrG94NvJCJzJLZwEi3JIbb0UapCsn4cR/M1gCCg
	 VXQ0xz6iqVzA77D/7cGz35z7f8WONgsikucRMj3DViRlldTDJFot4HAOi8x4ggHxNnTeD
	 iQB/feL5kV2RqOh33etg2BjCiVg3B/p4EWVoS9LEF0gdMkWivzYas+JzOc4GFE/YF/hMD
	 8I4vyxh4+SGlEDPgMJ2e8YyQvMXJclTkYy0OpEwtQt3hscYp9Ks9jjOfOBDdDzxDPXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LfpeBh1K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0580B606A321;
	Thu, 26 Nov 2026 03:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LfpeBh1K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F66F1F000C0;
	Thu, 26 Nov 2026 03:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795662819;
	bh=2Ib8aYZITDo/ZPmpEFTS6qhqZypmgy7XDQl+C7k59bg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LfpeBh1K10pS4Qv0815P2GMlhs3eUb++qM5yCCQWxVHkoWMjLapeED9yyOuaF15mD
	 GWPnFny6IkXku0G7oJ5mjeuvUrUcAoZA8wIahSn0dJrAknLMrO0vj1NzDDnnTkT9vq
	 oKcwMK0QYIHQwoC08lwxACgq/L/Pek+17lU5vlpUn3SVhJ5V0Yc2kz+Jpu7wCecQdH
	 1hKYr0cvX9XKbkZXPHCgSwKAbbwKiIhZeMXAZR3rsa2u0sqtx4VENy4Ywf8d52LIRz
	 GlPpp8kne+KEbddqVm3i10pQshEQc7PKVExpc/qhRDe2+bVsHFcj+MnaaK4kRTl2eV
	 8R5kQMQzDGZ4Q==
Date: Wed, 25 Nov 2026 19:13:37 -0800
From: "Peter Chen (Qualcomm)" <peter.chen@kernel.org>
To: Mario Behn <mario.behn@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] usb: chipidea: udc: give up when the endpoint halt bit
 is not taken
Message-ID: <awej4edcffKnljdt@hu-petche-lv.qualcomm.com>
References: <20261105205343.982465-1-mario.behn@gmail.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105205343.982465-1-mario.behn@gmail.com>

On 26-11-05 21:53:42, Mario Behn wrote:
> hw_ep_set_halt() writes the stall bit of an endpoint and loops until it
> reads back. On endpoint 0 the controller clears the stall bit itself when
> a SETUP packet arrives, so when one arrives while the driver stalls the
> endpoint the loop never ends. It runs in the UDC interrupt thread with the
> controller lock held, and the SETUP packet it is waiting out can only be
> consumed by that same thread.
> 
> Seen on a Zynq-7000 (an ADALM-PLUTO class board, PREEMPT_RT) during the
> host RNDIS initialisation: the gadget stalls the GET_ENCAPSULATED_RESPONSE
> poll that has no answer yet, the stall is refused, the interrupt thread
> spins for a minute, RCU stalls and every other USB operation blocks on the
> lock. With a bounded loop the condition shows on 1 to 3 percent of boots
> and is harmless: the pending SETUP packet is handled next and the host
> repeats its poll.
> 
> Retry for about a millisecond, then warn with the endpoint control and
> setup status registers and return -EBUSY. The callers already report a
> failed stall.
> 
> A loop timeout for the same hang was proposed in 2021 (usb: chipidea: add
> loop timeout for hw_ep_set_halt(), Jeaho Hwang) and not applied.
> 
> Signed-off-by: Mario Behn <mario.behn@gmail.com>

Please add Fixes tag and Cc to stable tree.

Peter
> ---
>  drivers/usb/chipidea/udc.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
> index d52f89489893..4f4e6d296de5 100644
> --- a/drivers/usb/chipidea/udc.c
> +++ b/drivers/usb/chipidea/udc.c
> @@ -224,20 +224,28 @@ static int hw_ep_prime(struct ci_hdrc *ci, int num, int dir, int is_ctrl)
>   */
>  static int hw_ep_set_halt(struct ci_hdrc *ci, int num, int dir, int value)
>  {
> +	enum ci_hw_regs reg = OP_ENDPTCTRL + num;
> +	u32 mask_xs = (dir == TX) ? ENDPTCTRL_TXS : ENDPTCTRL_RXS;
> +	u32 mask_xr = (dir == TX) ? ENDPTCTRL_TXR : ENDPTCTRL_RXR;
> +	int retries = 1000;
> +
>  	if (value != 0 && value != 1)
>  		return -EINVAL;
>  
>  	do {
> -		enum ci_hw_regs reg = OP_ENDPTCTRL + num;
> -		u32 mask_xs = (dir == TX) ? ENDPTCTRL_TXS : ENDPTCTRL_RXS;
> -		u32 mask_xr = (dir == TX) ? ENDPTCTRL_TXR : ENDPTCTRL_RXR;
> -
>  		/* data toggle - reserved for EP0 but it's in ESS */
>  		hw_write(ci, reg, mask_xs|mask_xr,
>  			  value ? mask_xs : mask_xr);
> -	} while (value != hw_ep_get_halt(ci, num, dir));
> -
> -	return 0;
> +		if (value == hw_ep_get_halt(ci, num, dir))
> +			return 0;
> +		udelay(1);
> +	} while (--retries);
> +
> +	dev_warn_ratelimited(ci->dev,
> +			     "ep%d%s: halt=%d not taken, ENDPTCTRL 0x%08x ENDPTSETUPSTAT 0x%08x\n",
> +			     num, dir == TX ? "in" : "out", value, hw_read(ci, reg, ~0),
> +			     hw_read(ci, OP_ENDPTSETUPSTAT, ~0));
> +	return -EBUSY;
>  }
>  
>  /**
> -- 
> 2.53.0
> 

-- 

Thanks,
Peter Chen
