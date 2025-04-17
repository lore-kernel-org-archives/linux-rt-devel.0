Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8116A2475C7;
	Thu, 17 Apr 2025 15:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744902678; cv=none; b=WClIdkyTdNmBV3jYN151OP3vuTp6XcJmjUn4Fo3gg4dd81Vv4YLvtqKHGEE5RIaYi/5KkyPJLwQC1p4Xcrx0fZ2CwX0sBq16zrc0mK8OsE6TbJ9kTS85RhMGYxUKfhjwmf3I8/j6qoPqPS8fNtjBJq4OJA+rR2CVvLFNaPvieaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744902678; c=relaxed/simple;
	bh=E5X679uCPTpvbUEqHbRpM/QTNZhAVmDvQfzsKO4PpZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=az+QLZVACxFmZ/GkXFzCP0/8mTeg1aSonTQETJaaR1turdDJLJ4JMm/uRdkZcMsqA8l37VTxM/8H7d6mUAyohwjCS2wPP/TnNGDHkLYs6iYSEIj3kmpG315oEJa9oqGJHn+3x/5ISqBiDjulfWclaFvpSfBqO5zO9jZ01J1DSKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DLlMefr8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uSvd5H2/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DLlMefr8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uSvd5H2/"
Date: Thu, 17 Apr 2025 17:11:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744902674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A447NPfUbEt6lE5p6p/8N6z6RAiec9Hb+rOLO+lknAY=;
	b=DLlMefr8mPvyddF0F4L+paGa/bkNrTTg5Z8lK2Ms6UeU9exl7xKccuJR8TACqyrR6r7noq
	kB4tFbVZPNy5lVJJ/VqbL8WRGoA/e4InC3i5F1Y+riQG/mnKTamztVuf0orlfCpdcjN5Zd
	O0WUVOGlVvxyKZQgxmLfM55ZaAuYP3t2bn9PlBzgoyv7PrBF/tbmMYsCMIHj1kRWgnomH7
	tixdkYuV8m5mZwW9w6IfpRV89DzhI+6tCYJtCMWbGKeDjvDqAyswyDFcRgB0WXck87lujn
	mO00Rr1BibjhhUjFeUvMjvCpSu8YR15NIjGQpp8s2kG2FfspJskyLBW6mF72tQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744902674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A447NPfUbEt6lE5p6p/8N6z6RAiec9Hb+rOLO+lknAY=;
	b=uSvd5H2/iQWgLwz53npXjF8a/6AKjTvDI3kxE5pKAbkFIYXeFZ244xjyLoAUZyiVpWyyDR
	gF8fWvnXva18AdBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Gustavo Padovan <gus@collabora.com>
Cc: kernelci <kernelci@lists.linux.dev>,
	linux-rt-devel <linux-rt-devel@lists.linux.dev>,
	stable-rt <stable-rt@vger.kernel.org>,
	Daniel Wagner <wagi@monom.org>
Subject: Re: PREEMPT_RT testing on kernelci
Message-ID: <20250417151113.W9MG8dy3@linutronix.de>
References: <20250211090511.xeFJVnH_@linutronix.de>
 <194f4c989de.bdd18d3279996.2067896388251039576@collabora.com>
 <20250211152018.sK91dh93@linutronix.de>
 <194f5b4b029.e5ee4014194612.536900249866001318@collabora.com>
 <20250213085256.nhWptGL3@linutronix.de>
 <20250411194432.pwc6U7Ds@linutronix.de>
 <19634ddfa6f.10623b4b6827067.8120388710582651736@collabora.com>
 <20250417100410.zxlZCBp-@linutronix.de>
 <19643df8092.ac2e879d858176.2114269254543526159@collabora.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <19643df8092.ac2e879d858176.2114269254543526159@collabora.com>

On 2025-04-17 10:10:43 [-0300], Gustavo Padovan wrote:
> 
> 
> ---- On Thu, 17 Apr 2025 07:04:10 -0300 Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote ---
> 
>  > On 2025-04-14 12:14:44 [-0300], Gustavo Padovan wrote: 
>  > > Hi Sebastian, 
>  > Hi Gustavo, 
>  >  
>  > > In my understanding you want to know when results for any rt-tests change status (eg PASS -> FAIL or 
>  > > vice versa) for a selection of trees (eg mainline, next, etc). Can you confirm? 
>  >  
>  > The results change is definitely interesting. The other thing is what is 
>  > tested and how. I remember you added/ changed some architectures for the 
>  > RT subset. I also assume that warnings at bootime (as in lockdep or 
>  > general warnings) are reported. 
> 
> We have some support around that, but this work is still evolving.

Okay.

>  > I remember Daniel asked for some cyclictests/rt-tests integration so I 
>  > don't know what is tested here ;) 
>  >  
>  > From the commandline you sent that there are a few boards running the 
>  > cyclictests and everything either passes or is in state "INCONCLUSIVE". 
>  > So this looks nice. 
> 
> Okay.
> 
> As for notifications, for which trees/branches you want to see it?

Linus' master and the -next tree would be good. If you plan add to add
Cc here, it would be nice if you could add linux-rt-devel@lists.linux.dev

Sebastian
