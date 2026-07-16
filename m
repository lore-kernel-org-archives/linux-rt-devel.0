Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D8A41D646
	for <linux-rt-devel@lists.linux.dev>; Thu, 16 Jul 2026 13:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784207619; cv=none; b=gjRV3PQ6+QbysxuHEtQLrVdrW5aeg7Cq5aEAuaTRwdowIVJa4gRy48/i+mwifsnyr2cWzRg7KFAMHWwi3b5P3p4FWLQvuVT5Q0FDoGd07E03p8eKOcCWyi1hh+ely7d492NJEojiRExoeJ/E89g0uj6HNHJVUoMpSjsYJJzrVqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784207619; c=relaxed/simple;
	bh=l2wYlPKoPn1wcA0Cb9ElP+k05wUzmXs20MA4PcGRH6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i09NkDZgPr419V5692wnTp/8CJ5fUzW2Hgdt98n4xp7B2mwYClViMdYYy+35UtEzUTjN/eDY2Z7ZxTtgcCVLh/5o/rO/Z8cuHPi0BEL/bft29TKBXIH5DG2u5Nfg2ABmPo2/++fP5KEUSz+BURdQ2OEQZSQDpwUEjrT6cUUWGXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E+9Sk7hc; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E+9Sk7hc"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493f25d47dcso19393705e9.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 16 Jul 2026 06:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784207611; x=1784812411; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HP1xYRFn9L2tLIdTryxjblP9c+avAGhHub41HiA5F0c=;
        b=E+9Sk7hcqKfy5wW80j1hqIFATNgAbLyiiEN0AW3EYGvZYUwq5KWPzEHsY7bYrcvgKK
         sIXxysUAfu1UfeS+WivvWzUk8RejoWq80kTjtPAzV1F7i2CkPPTKfyxo926CJmWXQfP6
         L/GqolTfEQIo7cRhJ87reBnaFbdCsv7f+mDTDYXIVf/2ZmJvcJUw7mQUkGSr5nchT2io
         +hI/06pEbzJrQ2BhCKgPZjauA0B/mc1KIjbdiv7SDnOqNxRd9ENyNyvFS1Q/G9W3WJT6
         pfPWS7LWlSCtqkNBsEFp7D6814J5rT5R3UY71EDpfPebrjthBETxxvUDQqMmHfWgZK1i
         5LFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784207611; x=1784812411;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HP1xYRFn9L2tLIdTryxjblP9c+avAGhHub41HiA5F0c=;
        b=ZC2z1B8jDZvIAVP5dNezFkCjEGs3ebk5XWK8YxGnrvFgYLG0nBANF2sdnqboPAG5bi
         Hkzq8K2uTDb8Y68rJyWJKMkrribluB2sjs6BD6IJCiAuCAAHwy9+hp+XGlI5e9Ps+EUR
         C/yoelZLYAaczod0mxaa6Q00ejulR0coK9UoRxWT02sc7v3kgqrqoNXRn7Q/6Q4uUDKw
         I8DmL6a8bhrDqnGNTqyA8216BFpeu/mcUDjyR7VyCYTkxY2wqA4/ubYOL2GNB59UUrT0
         OmaQk7skZkyCoVmIgem4fi9zzkNFjrt+1UPCDuDRk5ZrgZSwzTwdlEA+yVI8ne15rRak
         4n2g==
X-Forwarded-Encrypted: i=1; AHgh+RoU3Cn68S0mIHam7CpWBnedWq0v0HEZP5pgV63wytJEvi3ioR+Rhr6ZbZlgQVmrrYKS4uV8RZq7S/P0scxIJQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywsw7IoFHQv/EpvmOfjxI7mjf/K7YKE+m1npII70I90vk1XhQaP
	7hMOknApcoIh9z5DCVfgkFgX+20SMp2GynSo3Oc5T+40mLhbys3T1rVCNS8EHc6odQA=
X-Gm-Gg: AfdE7cmobWB6b+wS2//cuvufguqmBD3TI30V2Jr9yhY77EZbDrMLx/TO3+KL+RMbVX4
	OPL+7Pm0h/CRjcwkWuVq0bzg+GwU6eV/VPQwugtnHMT44oWvcIgq/51q/Ue3i/EFwpETotbbx4t
	QJiaXAn7dYPfNr+/iqGImNiTFx4kfNK6LT53iKQq7b/WYoMaaGAwNaUC/dehbTzzEtvR7kCxJX8
	eWeoyNKi8uMirYYL2oFgtfCb+3n+SLCtfA07Pl0YoBh4JsC3kQsn/fVsAhstHYYDpJ0gt8W9UxU
	cX7hYSeSlSHNadT3qUXodsy+g/9zCHlDAXfMEDtY+kjAeLNk/umUQFCIYRyK1yPJDbXzdi1oc8E
	s0LoGecxUMp1RG2Ms+h1p3aP2hawyECn68Wk2UwU0M/tMJKQmPS/mK2AceT+Jj26pbiB8ZuZFbV
	Ukue/V
X-Received: by 2002:a05:600c:4ed2:b0:495:3c8c:c16a with SMTP id 5b1f17b1804b1-49541248d08mr37275695e9.0.1784207611203;
        Thu, 16 Jul 2026 06:13:31 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4953c7006dfsm90819375e9.1.2026.07.16.06.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 06:13:29 -0700 (PDT)
Date: Thu, 16 Jul 2026 15:13:27 +0200
From: Petr Mladek <pmladek@suse.com>
To: Andrew Murray <amurray@thegoodpenguin.co.uk>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v3 2/6] printk: add bounds checking to boot_delay
Message-ID: <aljY9xfK-TcU_Fpf@pathway.suse.cz>
References: <20260712-printkcleanup-v3-0-574547b8f71b@thegoodpenguin.co.uk>
 <20260712-printkcleanup-v3-2-574547b8f71b@thegoodpenguin.co.uk>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260712-printkcleanup-v3-2-574547b8f71b@thegoodpenguin.co.uk>

On Sun 2026-07-12 11:20:33, Andrew Murray wrote:
> As the boot_delay kernel parameter represents a duration in
> milliseconds, let's set its type to be unsigned int and add
> bounds checking.
> 
> Please note that the existing pr_debug will only be displayed
> when boot_delay is non-zero:
> 
>  pr_debug("printk_delay: %u, preset_lpj: %ld, lpj: %lu, "
>           "HZ: %d, loops_per_msec: %llu\n",
>           printk_delay_msec, preset_lpj, lpj, HZ, loops_per_msec);
> 
> Signed-off-by: Andrew Murray <amurray@thegoodpenguin.co.uk>
> ---
>  kernel/printk/printk.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 31aabdf8248cc39c54ee11685d4a37deac1c174c..8be562c9be277670ba3209ed1f810fc87175848a 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1291,19 +1291,22 @@ static bool suppress_message_printing(int level)
>  
>  #ifdef CONFIG_BOOT_PRINTK_DELAY
>  
> -static int boot_delay; /* msecs delay after each printk during bootup */
> +static unsigned int boot_delay; /* msecs delay after each printk during bootup */
>  static unsigned long long loops_per_msec;	/* based on boot_delay */
>  
>  static int __init boot_delay_setup(char *str)
>  {
>  	unsigned long lpj;
> +	int boot_delay_val;

As Sashiko AI pointed out [1], the variable should get initialized:

	int boot_delay_val = 0;

get_option() keeps the original (random) value, for example, when the given
string is empty.

[1] https://sashiko.dev/#/patchset/20260712-printkcleanup-v3-0-574547b8f71b%40thegoodpenguin.co.uk

>  	lpj = preset_lpj ? preset_lpj : 1000000;	/* some guess */
>  	loops_per_msec = (unsigned long long)lpj / 1000 * HZ;
>  
> -	get_option(&str, &boot_delay);
> -	if (boot_delay > 10 * 1000)
> -		boot_delay = 0;
> +	get_option(&str, &boot_delay_val);
> +	if (boot_delay_val < 0 || boot_delay_val > 10 * 1000)
> +		return 0;
> +
> +	boot_delay = (unsigned int)boot_delay_val;
>  
>  	pr_debug("boot_delay: %u, preset_lpj: %ld, lpj: %lu, "
>  		"HZ: %d, loops_per_msec: %llu\n",

The problem gets fixed in 4th patch. But should fix it here as well
to do not break bisection. Also later changes might get reverted from
other reasons, ...

With the initialized variable:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
