Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508CE2512FD;
	Tue, 11 Feb 2025 15:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739288283; cv=none; b=kYtvR4MfVcesJwupqktcp9K8TuKcxwG9yV57vX5k7e9bg2jCgO+LUMlGX8Kyg4CfyJONfp5rjPu4C7MbbMD63cGkNxrGrRyHM4vEKUJKKut6zWp8juCubO6az1iHlC7dZZP8QBBwadVTobblBIRsnN+rRz0P+JQz7tmpLwrqNkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739288283; c=relaxed/simple;
	bh=31AOtQAl8hGAGsXFbgOp6lgCy/DMc4knulDj5MVNGv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1LaO3FH7ygTWXcwnlbOuUd38IpvWA0irS9sAyMQgJ5VKLzEJFCiEy0CHtWbOYIDI6qvL6JDpW6cKYi0W2r3cLX8NUcsEwYeKTAr0ELaVlyaDJyNBjpul98GxSYI8beMXrfKCxjpTPmksmyfeloeLhONHmGYQ+Q1RNsqVuUmXtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jJsJhb5q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w5gfz0OP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jJsJhb5q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w5gfz0OP"
Date: Tue, 11 Feb 2025 16:37:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739288280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=31AOtQAl8hGAGsXFbgOp6lgCy/DMc4knulDj5MVNGv8=;
	b=jJsJhb5qdI1rEOG4oYLrLprOTFLI+acnJWI8ElULPT+7Q+VByddN6HtdSnXPgRdHJTx2Ij
	4rtYfJxlgDogCczxClf3bhKyAm42FRLllbzHwMk/alqUYHt2oNo8DKk5j6zq1Co2Qe7jNY
	kE9yu86PhztwBvT4Xy+gHfOskbC8P9sJR85otBtB4g4fxMgkKqNDrPT8UpdTlu4AQM/dyF
	x1ozUo+i1Bs9cMEVqclE6MY2HxxgryUNEWLoVUOJP9CAN+69n7xvBke915mrgj+vkmxWdV
	T/iMsXUePqPuZnZDjVF6MSEuLPQfRxRnehp4YVUsdkoTInvmf1ihgp/eBEG1Pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739288280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=31AOtQAl8hGAGsXFbgOp6lgCy/DMc4knulDj5MVNGv8=;
	b=w5gfz0OPedy6SZtqjRUnKy2YWTZx+wtJCCDUfxWTlTEEretom+Q+5IvKrdJ13+svRmpvdd
	yvnnMWWW2JAbOxDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Guenter Roeck <groeck@google.com>
Cc: kernelci@lists.linux.dev, linux-rt-devel@lists.linux.dev,
	stable-rt@vger.kernel.org, Daniel Wagner <wagi@monom.org>
Subject: Re: PREEMPT_RT testing on kernelci
Message-ID: <20250211153759.5sSPp1PI@linutronix.de>
References: <20250211090511.xeFJVnH_@linutronix.de>
 <CABXOdTeLUi8mKkV38SegM_n8=Uyykd-X+n7RysjpgAZfxxb5BQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABXOdTeLUi8mKkV38SegM_n8=Uyykd-X+n7RysjpgAZfxxb5BQ@mail.gmail.com>

On 2025-02-11 07:33:57 [-0800], Guenter Roeck wrote:
> Unrelated to KernelCI - how stable is PREEMPT_RT in practice ? Reason
> for asking is that I enabled it for x86_64 together with lock
> debugging and got an almost immediate "sleeping function called"
> backtrace.

If I would have seen it I would have acted. My guess is that this is
something not a lot of people observed.

> Thanks,
> Guenter

Sebastian
