Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A451F8755
	for <linux-rt-devel@lists.linux.dev>; Thu,  2 Apr 2026 13:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775137598; cv=none; b=GO5ckxNMZ9on5gDHaSVIhuWa8ygcscmqTsGU2QSRl83N5pdkpWtEvDfM2nIhrSFmzdDo0/cgGhoBrwUDFEBQsTgiDEIKIfpa2HzNzf7Fum1XQXrJyq2ZQQ+dIdTstnMfOulUVsgJ1DCPGthcOzGdr0U9NXc2notIl4DCUHCHCvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775137598; c=relaxed/simple;
	bh=d+P+EsqVeeoMF8/3WOEXPIQ3KE1cp8zvoEmXP+T1AMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9kb9X9U0gn76E0SIPFN1jsUglLPf01qH/w+s3JJZjzpa0oXeB3qQ/1SAsJSlN7wmuEZHV69a9vU9nzR+TKLB55Sd2fRfTG9s2z3WKLINVukBLeEqvq75RWinGby7+KF2UQpQPC89l/C60qnfcLAhhv2IafteNABVr2q/o1HSK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kIpD+0UJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U4zQupY9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kIpD+0UJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U4zQupY9"
Date: Thu, 2 Apr 2026 15:46:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1775137595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7+1mm6JU2ay/udIfhcEewU+WST4SDt/bfv6S8nospS0=;
	b=kIpD+0UJtHUyzBV86+b5wKoWeqPSEyTg0G3fx6XNQ2Zu52ql0HMWuiuvfAy9tb0R+dQ52F
	l8z9uDlq+ya+pN/j4pndjYrGQiDTzFvgQwSWAb9suLFWMOp6yp23EhArDkUnrB4tDsFeD+
	G/ngTrgdzjTWjd3aArb4RqG3OegeKpHbEhdfiZ1sGvD0Pyf32yyXTuDDS8XqLtmwY4dSv8
	Q0TAzhQ8A68aKqd3Kh3CKh3ZUCWXDE2b/BOLKXQUfhhs4NIvyqo3otWwpwaVC79cXpWYZZ
	RXVJujzDrHOjkgGTJQlGzZPVW3OBZmdx+AsVzR2TVA8njHacNaXCh89qn04qrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1775137595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7+1mm6JU2ay/udIfhcEewU+WST4SDt/bfv6S8nospS0=;
	b=U4zQupY97iwE1tX2M84I6aNUk4aYHhMrk8zMde6PREwwCN+VNMKDdxtiENfMk+FsC9j3u5
	FLhtry/8BAh3RNAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Daniel Vacek <neelx@suse.com>
Cc: edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, netdev@vger.kernel.org,
	spasswolf@web.de, tglx@linutronix.de,
	Aaron Tomlin <atomlin@atomlin.com>
Subject: Re: "Dead loop on virtual device" error without softirq-BKL on
 PREEMPT_RT
Message-ID: <20260402134633.bRxz1V8a@linutronix.de>
References: <20260226172927.2Ck9wZMw@linutronix.de>
 <20260318103009.2120920-1-neelx@suse.com>
 <20260318111849._MMol8Hr@linutronix.de>
 <CAPjX3FcRYNkYK2gerbRL4C9wXZPxWSs6=oTjzv5+msm4PQrfqA@mail.gmail.com>
 <20260318145101._iaDDpbE@linutronix.de>
 <CAPjX3FePCKQTaxB6zuo+_V09PZct=utw3vgJUTM_GrZQtv7_TA@mail.gmail.com>
 <20260402070319.vhRd6c-f@linutronix.de>
 <CAPjX3Ffz22M_ADE1xPqHOCyni1wLwc+reLTVyOrJ+gqNYY6vwg@mail.gmail.com>
 <20260402083123.1H4kyAEn@linutronix.de>
 <CAPjX3Ff8Zv2EArKaCSKFAAFfBCCVu0YgqHk3SV85BBPm6-D7HQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPjX3Ff8Zv2EArKaCSKFAAFfBCCVu0YgqHk3SV85BBPm6-D7HQ@mail.gmail.com>

On 2026-04-02 11:21:20 [+0200], Daniel Vacek wrote:
> 
> Well, that's the patch I originally sent then.
> 
> https://lore.kernel.org/linux-rt-devel/20260318103009.2120920-1-neelx@suse.com/

That was an alternative after everything was already done.

> --nX

Sebastian
