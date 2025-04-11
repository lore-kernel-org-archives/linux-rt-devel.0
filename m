Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC2626989C;
	Fri, 11 Apr 2025 19:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744400677; cv=none; b=pj8NWjuJBscqim5tp1IM4260IfwpCOt3CZru1ArIzK98M+UAPuNhVX2ZRffASNa7ec67VSWk3UXonDQ7P0btcI14fxgtn8Jr1stalAc7oMByuAGoQViNKYoPhfnDjoEKvnonJYq9l6whcbcFf8tpC7JiglmYCxPTIULNDGE39Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744400677; c=relaxed/simple;
	bh=/6v0zw5ak3f/ZZAspKY370OySndK9g5vXV6fKod9kqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2WKVHZfkA2BQyQJMPGhw3hAJ1t6F7QHYhvFYoDWvvNmbs2ZVK2tOiQBR4agS/ehCddlqEN2LumdhRCuaA8qBHFmhhAGMFuncmMBzYypAlxnO7R8wMyilTz+p4L8XZai945KKAPke3UHMgkQkOzJyhC7DwtXVSUf+K2jm+nVbTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gYSS4ir0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vz9n5VFg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gYSS4ir0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vz9n5VFg"
Date: Fri, 11 Apr 2025 21:44:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744400674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xQs9wonNrxU6bloYlGrlPFmXTxtcyoPcHDbYs2ntwY0=;
	b=gYSS4ir06p+cjhF8LTpR/CTZI1da3QrVO1s2oJcbS7SfkgIm8F4I4JNpGTu44mjgFlsFlV
	UXbC5lbZ9S/KbNMuf3WJjqOgVmZynbvryab3nbbmYQ/JHzLTy1ZgX/ctbW/ozRCDFBphBt
	8t7BTuXNxYea0vxfQJE98V1HtBnbhBEA+4p7nzaJpOoY4iQoLp8ngnX5o7emsnejSYsxGD
	7eAGsYydPE0iVZyTM17soX88UbPTbNI8ubwBCBKGkS6kLIgEg0AVJBRadU9OZ7rQxHjx4G
	S1yun29iElBaEDp62KWinjAxJFSPynrJkS8jJ67eh2lvtZZcZAvF1w9Jep13VQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744400674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xQs9wonNrxU6bloYlGrlPFmXTxtcyoPcHDbYs2ntwY0=;
	b=Vz9n5VFgohqys4/KOB3Jlp1CimyZROTd1PaEn5DZ3D3tuwd7B8SpRbkCnPda5PEmQXPb1K
	5+Uuzgq3K3ozP4BA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Gustavo Padovan <gus@collabora.com>
Cc: kernelci <kernelci@lists.linux.dev>,
	linux-rt-devel <linux-rt-devel@lists.linux.dev>,
	stable-rt <stable-rt@vger.kernel.org>,
	Daniel Wagner <wagi@monom.org>
Subject: Re: PREEMPT_RT testing on kernelci
Message-ID: <20250411194432.pwc6U7Ds@linutronix.de>
References: <20250211090511.xeFJVnH_@linutronix.de>
 <194f4c989de.bdd18d3279996.2067896388251039576@collabora.com>
 <20250211152018.sK91dh93@linutronix.de>
 <194f5b4b029.e5ee4014194612.536900249866001318@collabora.com>
 <20250213085256.nhWptGL3@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250213085256.nhWptGL3@linutronix.de>

On 2025-02-13 09:52:56 [+0100], To Gustavo Padovan wrote:
> On 2025-02-11 12:50:47 [-0300], Gustavo Padovan wrote:
> > Hi Sebastian,
Hi Gustavo,

> > That is one the current limitations in the dashboard. The CI systems are not sending
> > a clear signal yet that they completed all tests they wanted to run. They just submit
> > test result individually as they get finished. 
> > 
> > Imo, it is a priority to fix this as it is second time this week I get this feedback.
> 
> Ah okay. No need to rush. If you have something to look at, let me know
> and I will. Other than that I will lean back and wait for the bot to
> complain ;)
> 
> Thank you.

any updates on this?

> > Best,
> > 
> > - Gus

Sebastian
