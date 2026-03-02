Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8BD5733E
	for <linux-rt-devel@lists.linux.dev>; Mon,  2 Mar 2026 11:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772450153; cv=none; b=oYO924Ss70CF6AjEAGtI+UhSRowvNDN7boKifGqbcemC36hQScaGgTGWnVclZyO1DL1nQq0nctGfTPpc1qDHfdtsCYISd2tGbIrBdEah8Yy7g78xVP+nTPFzxhO2ZenCRKNr9Gr4SWHZl21OfnPaEdsZh8ylQUf/uhTlQqPYs54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772450153; c=relaxed/simple;
	bh=l3ObVbbSuSRxPBTXf3Vv9OdcIia/J6WW0N66FNoiIgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DbtmMlJy98IpTl8Ir/90ZbppQBnEoStic/fwmQLK6qV5CBY0vmZimxxAvdPhS/2ezr9ezDlOzWT0LwF4ng/ovfiGqVvY3EgzDW9GWhZTBQLaXhrq32kAXvSV+nrUPylZkDYiTW9LyLHmGcdB+s0U+syasXMgtfRXBes22EIkxgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y4WS3Edz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Kc3bVXpD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y4WS3Edz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kc3bVXpD"
Date: Mon, 2 Mar 2026 12:15:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772450151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l3ObVbbSuSRxPBTXf3Vv9OdcIia/J6WW0N66FNoiIgU=;
	b=y4WS3EdzcWqz1hylIGGfizt1kvfCBQSZnyc+lWfDrAedDk0jxYZf7yzxSG4vZ3XRekA2OL
	fn6bVG7yFpqPElC2uTSoWuYkw9JjLyed5IUuopc5PTAfm8hl1+sU8uzfZmx60V+tFTQfAX
	8qeawjFTPQrFF1sVnvMzB00+tW6rBm7ZuB2hkC0duw9+NvAKCqxQpjAM6sOZtaipCUGrPH
	seVOzrdMPz48wqSMuX7im2J4JXCTYo0s0x0PDYCzJNxl+RiNJB/UNnPIVcLYT9VZfuuAbP
	ZGNWCCUBzDFUy3PRCiURZWYCM4wB03eB3NH0u3+wZJMC0O2HPbpok/ACJY1tVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772450151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l3ObVbbSuSRxPBTXf3Vv9OdcIia/J6WW0N66FNoiIgU=;
	b=Kc3bVXpDDM0+m3gAoIAZL0SU4f8DsG7UottHT+9vpn3ANPjU8PkikrOJyCJbhv0c1TW6tb
	8mcg6+daSSNx44Bw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Bert Karwatzki <spasswolf@web.de>
Cc: Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	calvin@wbinvd.org, dschatzberg@meta.com, peterz@infradead.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: ~90s reboot delay with v6.19 and PREEMPT_RT
Message-ID: <20260302111549.7FTnr1bM@linutronix.de>
References: <aQufmyZ7X7NdfiCL@slm.duckdns.org>
 <20260219164648.3014-1-spasswolf@web.de>
 <20260225154341.32AjXoVi@linutronix.de>
 <6abee0b4bca811680a7f7fb6ab70bf27c6805cf5.camel@web.de>
 <20260225165954.180aRkaV@linutronix.de>
 <20260225223135.vjfaFo0c@linutronix.de>
 <20260227141332.74RtR9HK@linutronix.de>
 <5a10aefc709b723820a6508a29823e89de947495.camel@web.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5a10aefc709b723820a6508a29823e89de947495.camel@web.de>

On 2026-02-27 23:57:09 [+0100], Bert Karwatzki wrote:
> I tested this with 10 reboots, it worked 9 times, one reboot was delayed (perhaps
> for a different reason, sometime these delays occur on no-RT or older kernels, too)

Okay, thank you. I read this as Tested-by.

> Bert Karwatzki

Sebastian
