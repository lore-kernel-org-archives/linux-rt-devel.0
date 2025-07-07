Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169BF279DD7
	for <linux-rt-devel@lists.linux.dev>; Mon,  7 Jul 2025 07:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751875191; cv=none; b=cGMJNR9phAElyiKMahVVCw5HmbnvNrKpf7xW1vnj6MCXeqziLgmWdwWxQZ1P80AVOnoHQTm5TD2dqDhx/r1aF4uu6vkWyaABIECDTCxCzph+5BDRPFSsnSxen2d7wbJ6dbAL4aU44i8oFROVp5dTIlF9WxPuVMnl05TEVnd25NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751875191; c=relaxed/simple;
	bh=Dj+qxXiCUSeP0x/yiuTreh2KBqvpawX/fXAuHfKvQmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dg/9yBEwFrYlYw0Q+6gc1EJt6ga5M0g6tpgY1xBwbxcvhG754qEzjCrEzlHgqTktrstkXirUlcN3MYcgaX0xVZzSE6oCccalBo/tHWbk9JpnADjzZJJRNB+CpFL52etZu1K4r42wUbAN7WivPL6SFNvs9RaYHKGRLc4RlcqxxD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gMcyUUNm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cEnvC0hP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gMcyUUNm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cEnvC0hP"
Date: Mon, 7 Jul 2025 09:59:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751875188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2j2sSg0ZRy6nf1ETEjPyw/XMmKiPm3C8NPTr78onL3g=;
	b=gMcyUUNmlsL7Q9HhXkmRIE4Y9dchZAqXMwJGF1TKckzcfB9QBfjlDKH9FP6chQQO2PIs1q
	8loRX1KU00nJAKVWbZNhSO3oxCO+I0PE88o5fBA8aOOTl6U78iWq9zwyafokKDwuPbSpuI
	6MfmToBq8u2y1fyxlZfcawIFkcucjyyxCv7/H3kEz0wQ9Cpv6JRnnuBbpIayo/8xuhGemm
	ZJpeoYIkoD2z2N4enYyU5K3RU21ZFqoSVBLt4gYIDWOvpAeY7FZMes7GhciU7r5ZMIRTST
	XO5LOlDpux0Xh6MmNvXM4dZHwDc6dqZ8GSK0eXHx8VECWfdmY3aO8V/VAhhDxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751875188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2j2sSg0ZRy6nf1ETEjPyw/XMmKiPm3C8NPTr78onL3g=;
	b=cEnvC0hPGg1Bq8hyPVB+3C7SKRYFfYJe6IsXApn3j7vKcebOn5KyQZIAO0IHlh5LCruHS8
	+NhwieRBPOvadCAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
	dvyukov@google.com, vincenzo.frascino@arm.com,
	kpm@linux-foundation.org, clrkwllms@kernel.org, rostedt@goodmis.org,
	byungchul@sk.com, max.byungchul.park@gmail.com,
	kasan-dev@googlegroups.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	nd@arm.com, Yunseong Kim <ysk@kzalloc.com>
Subject: Re: [PATCH] kasan: don't call find_vm_area() in in_interrupt() for
 possible deadlock
Message-ID: <20250707075946.2lAwc0OR@linutronix.de>
References: <20250701203545.216719-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250701203545.216719-1-yeoreum.yun@arm.com>

On 2025-07-01 21:35:45 [+0100], Yeoreum Yun wrote:
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 8357e1a33699..61c590e8005e 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -387,7 +387,7 @@ static inline struct vm_struct *kasan_find_vm_area(void *addr)
>  	static DEFINE_WAIT_OVERRIDE_MAP(vmalloc_map, LD_WAIT_SLEEP);
>  	struct vm_struct *va;
> 
> -	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT) || in_interrupt())

Could we stick to irq_count() ?

>  		return NULL;
> 
>  	/*

Sebastian
