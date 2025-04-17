Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EC322838F;
	Thu, 17 Apr 2025 10:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744884255; cv=none; b=GGrUAMfT4uFZxTSn12Cxrt7i/pcnxSlO81oGb+HcSpyym92iBKfGI8y04KHLr4k755Wplxtobf7LzXGxVwWhLicQt/8+tCOXg7PstuRiBVUOJoi84N5nAl2reuMxiALEqMXeM5KEbvUGu1SVak3To+6rn1+W9rQwPtCdLJ3MFtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744884255; c=relaxed/simple;
	bh=OFzXf7jvY+c17aYscHxUDlCWUuuG3alGM9T+8p74OMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qsphicq45/y7003TOYxY3Y/DtC8WZ/lZkj6rOoJXg1FclxldSMxurZal037wPbWoUCZIevgn9NT/upbvHIYUeDgVzlOVd12m9MEhz3CNksY4y5ijm5PxR7O1ZbXKblii1TDnjjxpGw29g9hJbpX9BiHaPvaKJwYlrJ5LncjP6K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T4Xxy+gg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WE9vlUVJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T4Xxy+gg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WE9vlUVJ"
Date: Thu, 17 Apr 2025 12:04:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744884251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wfhgToccHf3QZWcPYj5WceZrvcUFgt1v6i1Zw1B0kGg=;
	b=T4Xxy+ggbyGO2shFq6ZV2p8MMmUNTZsp3MNXKddm/EgacgSrEZsV1PQqiKOYq3fsa3wmCl
	XICrm0VA7NTrQ2PtHlCiiALjZKLUPZ+/q8prhLLlTxAsYIhg2G0bMEqxftgF20AGEpGISh
	mWUd1KterfjK9k0/2UuyJB2dqv6NircVjZEHo8/Set/aK1qA0IwUGOACmJ+5OKE7XllFhb
	YZGKwh7enu5FAqMRHrh53Ft4VVOOOoRZOkMbFApPWb2IjlPdgRw+82frZ5rkh0Nf6iTVIn
	XAiaNOHAEKK4WamxzDZK6sVPFuNOQaMixUdFCxIl6jC5B/8Gs7qiJn7hThXXuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744884251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wfhgToccHf3QZWcPYj5WceZrvcUFgt1v6i1Zw1B0kGg=;
	b=WE9vlUVJ4P1rFGAQFPCtxZ3DZSZUmcDYbnB5cuCnf5E808y5QASrWCoYecSK2H3WrG6uBh
	o2f4X/GjhRm+2fDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Gustavo Padovan <gus@collabora.com>
Cc: kernelci <kernelci@lists.linux.dev>,
	linux-rt-devel <linux-rt-devel@lists.linux.dev>,
	stable-rt <stable-rt@vger.kernel.org>,
	Daniel Wagner <wagi@monom.org>
Subject: Re: PREEMPT_RT testing on kernelci
Message-ID: <20250417100410.zxlZCBp-@linutronix.de>
References: <20250211090511.xeFJVnH_@linutronix.de>
 <194f4c989de.bdd18d3279996.2067896388251039576@collabora.com>
 <20250211152018.sK91dh93@linutronix.de>
 <194f5b4b029.e5ee4014194612.536900249866001318@collabora.com>
 <20250213085256.nhWptGL3@linutronix.de>
 <20250411194432.pwc6U7Ds@linutronix.de>
 <19634ddfa6f.10623b4b6827067.8120388710582651736@collabora.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <19634ddfa6f.10623b4b6827067.8120388710582651736@collabora.com>

On 2025-04-14 12:14:44 [-0300], Gustavo Padovan wrote:
> Hi Sebastian,
Hi Gustavo,

> In my understanding you want to know when results for any rt-tests change status (eg PASS -> FAIL or
> vice versa) for a selection of trees (eg mainline, next, etc). Can you confirm?

The results change is definitely interesting. The other thing is what is
tested and how. I remember you added/ changed some architectures for the
RT subset. I also assume that warnings at bootime (as in lockdep or
general warnings) are reported.
I remember Daniel asked for some cyclictests/rt-tests integration so I
don't know what is tested here ;)

From the commandline you sent that there are a few boards running the
cyclictests and everything either passes or is in state "INCONCLUSIVE".
So this looks nice.

> Best,
> 
> - Gus

Sebastian
