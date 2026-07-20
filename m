Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA07400DE8
	for <linux-rt-devel@lists.linux.dev>; Mon, 20 Jul 2026 11:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784547967; cv=none; b=f7geuvqhoye4JPdFOcYXevaHWqzXn2bFmRcGjfxoaU8vdjvzQMDcAo9l7KMxXu3uAi9boW/10FCJ/GMv+scdCYiLBjg+Y6LfJTvMrcXDC/SvEwmaELokJTvdMJo+iFIcieGBgXRcmjioYcg49SAC1XJN3NEflJTUcwhLqohWO4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784547967; c=relaxed/simple;
	bh=fUp4cei3BPr8E914jW1LFi71X7u+EpY3vf8k/rOCOA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWuzjRxWyFoDVHcqoJ7Hqspl/8VTGlV7s2n8a8xf3LBQSDFkjD147MCbkobrnkkEfQpiOS8ZnVVTW9S18SllS6dlQSKFPhE7Oogs9B6vxLdumaIaLFSV0U/uC/bOi+mYkf6vPH8dIkKFuGFPHYfvsKRezcoYQ4ldAmCU7cJ/Ysc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bN6h4gI0; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bN6h4gI0"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47ddf7b09aaso6546919f8f.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 20 Jul 2026 04:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784547961; x=1785152761; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fsMxsXjpGTSr2po7Wxk96V1yFnPC/aTK9Y7JzwyoR2U=;
        b=bN6h4gI04I9xbp4OBFj0PjaB+hMea3FGHjWSMCR0J/EygWGLZ5u84i81GgTlivynOZ
         +TIlBro6VAXtuV+XuX/9ZiTTz7QppyWggd1Ma+WWT07qjPEn3xPekvbApc5L5UINfY8R
         70260/zPkorBlBmwvWsdh6cqFPW8nh9ZURBfCmiNoLl/Ks/0I6WDuOnoOHptWcslGmiZ
         LpvOCLtPsom5Vqx1H0lYU2tJFPjo0HgSa7ZRGJ0EdpM7/pGsrAEXU3pvTBp+c9po7/O7
         ieKQ1AppXGUR1PUV/66PIQIW9eJFjaP/Yry9OPVlULRQKbHt/eqad2CJjQqfGucr+mZr
         c/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784547961; x=1785152761;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fsMxsXjpGTSr2po7Wxk96V1yFnPC/aTK9Y7JzwyoR2U=;
        b=bHZkjcDbHVu2euGqfSe2dHVM804Afj3yt4dUPa+yR3tFENCIItdko6Z1ySkWgNrteH
         gafGsg/I+5XW1KjwX3OLT/jg7iHQ6YmEpuzgHDk5Ngn7QaDlR4Nh1ZGxAks+0uvuYTB0
         qyWucbV1BVuopcBlBqoJqy2LPOslvL7zJVJ//hohTih+EwT3CdlEYLBrMjs09Ptfjr6y
         TBGWC9C2ETY/sgx/Gh9zti+VGiNuy+hQEghF81nIPXju5w8vW8lRWiRI8UnQMEc3yHPP
         OMw48EsQP+QM/yc/L2Edi/pSGs/UJ0HVegl/kf1YIjC/ZXV1cDL2Hw8AO4jBCoPy3pvT
         wRcw==
X-Forwarded-Encrypted: i=1; AHgh+Rox+9gb7QtRtklHrr/WCX+YP61xb5QZppIHkykpZHRVBpts8ppBjTFQhzjSxg6d6HNFief2umvN96DZXpO6+Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzo53P30nKzMhjKtWlPXU1crCEJwPKN3UkcculV50mL+RiC1nJt
	NVjxCFoUEFR50Sk+3ivG8LY9LQ27meqrbq90ciU0MVxh1KK1gA4+lb+Wl9HcBeb5EEI=
X-Gm-Gg: AR+sD13wuO66QJdQQU9eE/Kp0rjz8rgEiXTeEOHsrZhNMsdgIU20T+ue0gp34NksUME
	1xYoXZw9TASt4kbFzyo0ZQ2vNd+SQjENflVnc5R4jx2hZa8O4koVHyBm3c50gTiU5GgpClapw4S
	s9lcU7Msu9TGwGxi+bYULrZZ9OnteLegwRiLVRsgDDjpTCEEiz2PB1XCEJhEMq8c2q946pAqGt9
	sh0ooQljmy8n9oM/2A5hKCbvo5qmddanzjAWsGjf5Pb53QyyfI/aJSKfbSfw6aVG8yK7mw5Fs6T
	3yt5g6xXBdc55Q++OHnXajo9LlnhB2RTo3LsF3t9qBH08VDt5HkPdDSkCI2Wqnct0sJ0WrZw8di
	b/uCWOQ2PkLizFR7bEI/rtZxBg9ykp2sT+Ahwpk+at1FBtJNmKKauyY1O4JvjW9TjOaD++1VKwO
	6RDGTI
X-Received: by 2002:adf:e351:0:b0:478:77c1:787c with SMTP id ffacd0b85a97d-47f6233bf07mr11020582f8f.56.1784547961445;
        Mon, 20 Jul 2026 04:46:01 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e65644sm27955963f8f.16.2026.07.20.04.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 04:46:00 -0700 (PDT)
Date: Mon, 20 Jul 2026 13:45:58 +0200
From: Petr Mladek <pmladek@suse.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev,
	Toshiyuki Sato <fj6611ie@aa.jp.fujitsu.com>,
	John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH 2/2] serial: amba-pl011: keep console clock enabled for
 atomic writes
Message-ID: <al4KdsU9YLOmwDoV@pathway.suse.cz>
References: <20260719063502.18852-1-kmehltretter@gmail.com>
 <20260719063502.18852-3-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260719063502.18852-3-kmehltretter@gmail.com>

Adding ARM mailing list into Cc.

On Sun 2026-07-19 08:35:02, Karl Mehltretter wrote:
> pl011_console_write_atomic() runs from nbcon atomic context, where
> sleeping is not allowed. It calls clk_enable(), which takes the
> common-clk enable_lock. Under PREEMPT_RT that is a sleeping lock:
> clk_enable_lock() first tries spin_trylock_irqsave(), but on contention
> falls back to spin_lock_irqsave(), so an atomic-context printk on an RT
> kernel with a clk-backed pl011 can trip:
> 
>   BUG: sleeping function called from invalid context at spinlock_rt.c:48
>     __might_resched from rt_spin_lock
>     rt_spin_lock from clk_enable_lock
>     clk_enable_lock from clk_enable
>     clk_enable from pl011_console_write_atomic
>     ... from vprintk_emit
> 
> This was found and reproduced on 32-bit ARM with PREEMPT_RT. In
> addition, write_atomic() may be invoked from NMI context and is
> documented to avoid locking. Since clk_enable() acquires the
> common-clock enable_lock, removing it from the callback also avoids a
> potentially unsafe NMI lock acquisition.
> 
> An nbcon atomic-capable console must be printable from any context, so
> the clock cannot be gated between writes. Enable the clock while the
> console is registered: use clk_prepare_enable() in
> pl011_console_setup(), release it via clk_disable_unprepare() in the
> console .exit() callback, and drop the per-write
> clk_enable()/clk_disable() pairs from write_atomic() and
> write_thread().
> 
> Keeping UARTCLK enabled may increase idle power on platforms where it
> would otherwise be gated between console writes.

Just to be sure. Is this acceptable, please?

I have no idea what is the real life effect. It might be negligible.
Or maybe it does not effect production systems at all because
they do not have the serial console enabled.

I just wonder if it might considerably increase the battery usage
of some devices, e.g. watches or earbuds, just because of the possibility
to write emergency messages via the serial console.

Best Regards,
Petr
