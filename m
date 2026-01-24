Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A4183A14;
	Sat, 24 Jan 2026 10:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769250070; cv=none; b=Ow4PIV0LVGT8hzlI3zd+4k3LlHhYHNbWZZfa+/f7bKi/gLzHf/88u9s9rHxEPMpmU9cj3A7DIoRsIRCUtpUwXOOT1er8dOYc5zJihHOKOM6xqo5tdyZa+e9LVmZOnjtuPcHU5wISxXBsWei6C632WG5eNUphXS3ZSHpb1cLcZPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769250070; c=relaxed/simple;
	bh=mNQX/Ppu4O9/RZXvxhKwRVhCG7FpYJJctQXWvXe3VyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iq5DP1Y7qgLLSI7GcL0EceW9DkSgudlte00v5+Y49ion351T/ltgOuZoNjR6wLAhbkRLUBcgVXCGnRo6npewCfImKYwb6x3B+vLX3U7x+Z9SNHzF2JAKGpX9E6irY/9X037rveoaFMROlV4wLgjCUyRyJrBR5YHeFfSDaj1A3Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rjbUZaQt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rjbUZaQt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A51BC19423;
	Sat, 24 Jan 2026 10:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769250070;
	bh=mNQX/Ppu4O9/RZXvxhKwRVhCG7FpYJJctQXWvXe3VyE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rjbUZaQt6Q46OA/X/gejvRXSRw9MTzpTSznfx69hlX6/enN2Wt6MEH0IEU2OhHDjH
	 HrdooaYb6L2AUk1WaiYwqtJBWPd7ng+RhWSB5fr6YIg5gzqDtZd9DBbexsW+9D6dUj
	 WDap83saj+lPgMIbPyyrag30SBA2KSBl02D7WbbvgRsP3nEhrQjeIL0vLz7/A3SXcJ
	 +eiRiBTzSHgipmsPXrAktRaOeR1fb9VUoIcKbiWVOajII1BYkvjH01StYdI8n190+p
	 kGPuqShOgEjFqL38L8vaq3PYG1x5jx7XRb2zMrd61qYLhsDrqhaekv7D0QUk9wd0lr
	 YdukmCHvbaodQ==
Message-ID: <a1072d80-118c-4b6e-ab39-301d137e1e2d@kernel.org>
Date: Sat, 24 Jan 2026 11:21:06 +0100
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/21] platform/x86: int0002: Remove IRQF_ONESHOT from
 request_irq()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org
Cc: linux-rt-devel@lists.linux.dev, Thomas Gleixner <tglx@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org,
 "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
 <20260123113708.416727-3-bigeasy@linutronix.de>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20260123113708.416727-3-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 23-Jan-26 12:36, Sebastian Andrzej Siewior wrote:
> Passing IRQF_ONESHOT ensures that the interrupt source is masked until
> the secondary (threaded) handler is done. If only a primary handler is
> used then the flag makes no sense because the interrupt can not fire
> (again) while its handler is running.
> The flag also disallows force-threading of the primary handler and the
> irq-core will warn about this.
> 
> The flag was added to match the flag on the shared handler which uses a
> threaded handler and therefore IRQF_ONESHOT. This is no longer needed
> because devm_request_irq() now passes IRQF_COND_ONESHOT for this case.
> 
> Revert adding IRQF_ONESHOT to irqflags.
> 
> Cc: Hans de Goede <hansg@kernel.org>
> Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
> Cc: platform-driver-x86@vger.kernel.org
> Reported-by: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
> Closes: https://lore.kernel.org/all/555f1c56-0f74-41bf-8bd2-6217e0aab0c6@intel.com
> Fixes: 8f812373d1958 ("platform/x86: intel: int0002_vgpio: Pass IRQF_ONESHOT to request_irq()")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Regards,

Hans



> ---
>  drivers/platform/x86/intel/int0002_vgpio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/int0002_vgpio.c b/drivers/platform/x86/intel/int0002_vgpio.c
> index 6f5629dc3f8db..562e880256436 100644
> --- a/drivers/platform/x86/intel/int0002_vgpio.c
> +++ b/drivers/platform/x86/intel/int0002_vgpio.c
> @@ -206,8 +206,8 @@ static int int0002_probe(struct platform_device *pdev)
>  	 * FIXME: augment this if we managed to pull handling of shared
>  	 * IRQs into gpiolib.
>  	 */
> -	ret = devm_request_irq(dev, irq, int0002_irq,
> -			       IRQF_ONESHOT | IRQF_SHARED, "INT0002", chip);
> +	ret = devm_request_irq(dev, irq, int0002_irq, IRQF_SHARED, "INT0002",
> +			       chip);
>  	if (ret) {
>  		dev_err(dev, "Error requesting IRQ %d: %d\n", irq, ret);
>  		return ret;

