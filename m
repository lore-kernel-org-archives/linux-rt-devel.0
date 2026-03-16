Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82123351C33
	for <linux-rt-devel@lists.linux.dev>; Mon, 16 Mar 2026 07:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773646399; cv=none; b=pVJ7xUddzniapHM8frVetSI1LXuvzYNjMfbn5YE+Ppoa99ALOgenUrf9Sw1Gy2lwUyKPp8PQWrK59sq+Ur6dxGD0Zlz/Tj2Ujo26uME0CRskn3fWcCthUS6ePBeheAn1WNG7q7pbF2nmHjb3uCTbDaRZaElPxIG0qFSFmo2hVOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773646399; c=relaxed/simple;
	bh=wSMbag88hHvbEyQCmnzjMxLIQKCHr4ePjhfjIJgxud8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2PfqPtAzLaXripUWevtYpuW5tpTr40Dzxm3b1NG+r/4y54hZq05Kyal8u19jkx4RjXyF187gybXrYTpFgOplRcpHGmHE7zaX576goZXz9XT+C0QZdjhl5Lj/zthQWxiGB8wpVj8dR4s0ZzacLck/V+a+grJ8HB89jVueo9tD6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sllPn9LR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x3W+iTbR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sllPn9LR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x3W+iTbR"
Date: Mon, 16 Mar 2026 08:33:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773646394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qE1qA34IPDZkBXscOis8z4uJrvtB59W6NldRXjUV34M=;
	b=sllPn9LRPewGRkD0ikxIvqaoKyVOq40+9gWX1griKIIEar/Ej2th1GSLnsY+vp5OqNx4eM
	ADQ0E9iP2rIQ4SwlQYZN4GqCKma7u71MzzZbBndgOlQVDZ35nDc12xEUVs4M9IUMu1Oknc
	elxhH3OrHosMcyaYgMpx1tTHs3dVRm1yuxGPfZO8JjWhIaKLfEIThoi13YNNzt39AAJ2pA
	dQfGl0VrBiU+2ZHMvKUdi4R2+mX+RmEHyXPD8SVLYggnJQqNTnrGnP4nqPZ/v/8e7Y/i0d
	6Qa5rnzWQRESQB/t04NXDXOGCkfV8JPK6QhSgz+Geh6IaIYeW6ZtiGeMLZ7LMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773646394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qE1qA34IPDZkBXscOis8z4uJrvtB59W6NldRXjUV34M=;
	b=x3W+iTbRq72f+85XvDVuEm8JJXoDW0XfVnjw/Wil9QWNKnHKzv4BdQagiU8ZvBo4sfaPIC
	oitwJA6GF/jSevBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: guoqi0226 <guoqi0226@163.com>
Cc: anna-maria@linutronix.de, frederic@kernel.org, tglx@kernel.org,
	clrkwllms@kernel.org, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2] hrtimer: Fix is_hard/is_soft both false with missing
 HARD/SOFT flag
Message-ID: <20260316073313.Z8CsTXwi@linutronix.de>
References: <20260315063009.146668-1-guoqi0226@163.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260315063009.146668-1-guoqi0226@163.com>

On 2026-03-15 14:30:09 [+0800], guoqi0226 wrote:
> When hrtimer mode is only ABS/REL (e.g. HRTIMER_MODE_ABS) with no explicit
> SOFT/HARD flag, and CONFIG_PREEMPT_RT is disabled, both timer->is_hard and
> is_soft become false, violating the hard/soft exclusive design rule.
> 
> Enforce correct hard/soft timer via effective_mode:
> - Enable softtimer when CONFIG_PREEMPT_RT is enabled and no HARD flag
> - Add HRTIMER_MODE_HARD to effective_mode when
>   CONFIG_PREEMPT_RT is disabled (e.g. HRTIMER_MODE_ABS)
> - Compute timer->is_hard as !!(effective_mode & HRTIMER_MODE_HARD)
> 
> This ensures exactly one of is_hard/is_soft is true.

How and where is this a problem?

> Signed-off-by: guoqi0226 <guoqi0226@163.com>

Sebastian
