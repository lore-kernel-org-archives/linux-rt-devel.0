Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795083158;
	b=iL4EMpifqfqG9NVfliW7hDFzBYbWNTA+v9AHKERDIfeH+Gky0bgNlTxx8QwroE3mONar
	 MyUoCQbrmBy7IFANa00OxO7LZ4o7JEOBoV/ga+FPFej8Yi3g9j0MZUBmkjKbRlVXI1T7X
	 uYeV72EYasL9V53bgPSSJo0qzXR9xiUllLKRYCvYdJNTbkty16JlWaFW6iffxaA5vSgso
	 pAht8N1pQoUDdyWNor3tkER5sI0BMCrV9yk+fwSZ0hpY7DRjt/PRBem5D3Q78Tvfh3CZx
	 IZ8FrynebO4Dwx8Q+JuEcPjsA4/gw0tU4pNFtx965D+4/ytK9TWDjF8OkyYm7MNn2kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795083158;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=3ml/Rxe7/9Iyni2kI53ZwlXSV/qBLUD5AtVdZuBgy60=;
	b=I4RUXBPSo5Ka/MZB1gQVv0U6TgBYeZItkdC/GyoLoO7Cj9Dqa39CW25hgc74L6cPVuc5
	 Ph+0ts/3JN3nmAFGd5CNqGXsm3d8nE5MkNhjDTtZSfDaJe1XmqSRSxbH7TwESf8q5oVB0
	 8n8telXj7sHm1ULkZab70Tad+brl2WZljH1kcu3WdKAFBvVebtMMwdsoFAEUuxURF4/5h
	 6LZsGVVZuuNrjxN77BOLmj0FUrgmUlP+8xBgqezH2j+9vIS54/BdAOWPpQJ5oA1T83OZi
	 Ak8fLIYQqcPsltz8RuI9t4Wl+a9dsWvuvBlgYsWOjCojAE/3/lD8THK0QOZOTxqerxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=ctLwCn8C;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=6VyJdNiG;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15881606A324;
	Thu, 19 Nov 2026 10:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15881606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=ctLwCn8C;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=6VyJdNiG
Date: Thu, 19 Nov 2026 11:12:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795083155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3ml/Rxe7/9Iyni2kI53ZwlXSV/qBLUD5AtVdZuBgy60=;
	b=ctLwCn8ChBfYftM2oFOcTkfGi7NGM+7FPNfYTFk1mZQEJ+aMTOVCgkMDywoPT27cADnpjy
	us0pixGXeeeTWzLT1kZ8QgiREoJkSYfgM4Glnq6HJexrep4wAPUnpJffUWbjrswuvoD4Mc
	5iGIfi3uiuhrxQkIJitdxviaVgiEU9eZ3oQc2l5QJ3g71rLrH7QcRTyIxEcakM7Mzs4g5I
	L+5WurA1I7oTqT9iotDsfGysPYoUnJtmDzeKg7ghek9HomBrEtBKe0qjhro317/qeQ59kg
	Z53q6+TrZgWrXXFqJeUzz7/lxtgHD8ld2lixwshUXR/bgMcz9fkG6F/tL7Hdvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795083155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3ml/Rxe7/9Iyni2kI53ZwlXSV/qBLUD5AtVdZuBgy60=;
	b=6VyJdNiGpJn/V7Jn+vwbUgpSwdBvOz6PSjEdg4AU0srXSg6EI1sBJd1qQ/LbJX12zpb/Sk
	TWFHbpwgkGwxGtCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: a0282524688@gmail.com
Cc: lee@kernel.org, Ming Yu <tmyu0@nuvoton.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	mfd@lists.linux.dev, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v10 05/13] mfd: nct6694: Drop the unused IRQ enable mask
Message-ID: <20261119101233.Z-LmZvya@linutronix.de>
References: <20261118081625.2399247-1-a0282524688@gmail.com>
 <20261118081625.2399247-6-a0282524688@gmail.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261118081625.2399247-6-a0282524688@gmail.com>

On 2026-11-18 16:16:16 [+0800], a0282524688@gmail.com wrote:
> From: Ming Yu <a0282524688@gmail.com>
> 
> The .irq_enable and .irq_disable callbacks only update the irq_enable
> bitmask under irq_lock, which is a spinlock_t. Nothing ever reads that
> bitmask, so the callbacks do not mask anything. They also take irq_lock
> while the IRQ core holds desc->lock, a raw spinlock. On PREEMPT_RT this
> is an invalid wait context.
> 
> Remove both callbacks, along with irq_enable and irq_lock, and keep
> IRQCHIP_SKIP_SET_WAKE. Without .irq_disable, the IRQ core falls back to
> lazy disable, and handle_simple_irq() keeps a disabled interrupt pending
> instead of calling its handler. The behaviour is therefore unchanged.
> 
> Fixes: 51dad33ede63 ("mfd: Add core driver for Nuvoton NCT6694")
> Signed-off-by: Ming Yu <a0282524688@gmail.com>

This sort of makes sense. But how does this work? If the interrupt keeps
coming the irq-core will just suppress it?
If that is your whole business why not use dummy_irq_chip?

As far as the change goes,

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
