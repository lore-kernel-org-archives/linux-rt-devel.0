Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC3930DEA3
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Feb 2026 07:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772006293; cv=none; b=YqjzgzkSL3ggMJiquKODrB3DreYxKB5owgbna7pFzdUv8V/+hiCtHb5b7gISW7fkyY7QkAnJUvTd6vJJ3I15tni1eEQTMsECtWZ3jxMiCMMp3tc08A0aHfaMH4Ur4Hb4Xm16lpIWTfNKPSFeu1S0WbTfrVnYsH7Wospn3UaISRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772006293; c=relaxed/simple;
	bh=wJBVKctBREgJf/OjUNnksp36krPT8S9f4OJpv8i9A+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b78dnoYRlzsRce0oYYu2dVQx9sTwiEIHThdh1mObZkqdv5uxC5u14ylfcUfkRrqygAw5xT9TJdb+b3BflU5Xu1l1yqSg409x7uBL8m2Ns/4q3tkZuBvgv5lds3R98NpsOl9cL0pukdlsRLRcvJjkI+ru0ucrh2ROq7NMGS6cvf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HPr/kFYf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XLFA0/wU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HPr/kFYf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XLFA0/wU"
Date: Wed, 25 Feb 2026 08:58:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772006287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wJBVKctBREgJf/OjUNnksp36krPT8S9f4OJpv8i9A+k=;
	b=HPr/kFYf3wXCddqxs8oPWktGZfOMNosB/4hTug22NHfBTyoDvhFYWvbDtS+U6Y1sl5eR9t
	LQEeZS9de8GfDsVKo51LW0DAE0x7WPaWIT4DUC7+nYa9a5EIgNa8+uQM6Eil7oNIvijziY
	vNR2U4WhNHVkCdxi6/s8CTAVvZlYHIdFH9oPJ5WuZYcpoudbyrab1kY8DnLOHmcVNfDrF5
	PB6xwPUo8csK7q2t66jnmDAF8iex4oFcZmMDzRRxIZxYHe9U2zfSHjP99+QBT9B6ksBECO
	TuRaJ/nRBRu5nqLWu+6RgzxqaIzT4mKME3jeerXYWgg8W1YLWJIgtZo+NxMg4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772006287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wJBVKctBREgJf/OjUNnksp36krPT8S9f4OJpv8i9A+k=;
	b=XLFA0/wUEp+ZFBJf9wUtiuwYnDjmjjNN3W9FVMJDNWHIEWP5ces0UuhNrxRvBqZXPqoi9z
	4ZXUSN9NR94V0qAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	linux-rt-devel@lists.linux.dev, dri-devel@lists.freedesktop.org
Subject: Re: [i915-rt v6 00/24] drm/i915/display: All patches to make
 PREEMPT_RT work on i915 + xe.
Message-ID: <20260225075806.XNtXjZ5E@linutronix.de>
References: <20260220083657.28815-26-dev@lankhorst.se>
 <20260224162703.Q_taYjEC@linutronix.de>
 <20260224165903.2mn24oQy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260224165903.2mn24oQy@linutronix.de>

On 2026-02-24 17:59:04 [+0100], To Maarten Lankhorst wrote:
=E2=80=A6
> This one I can reproduce while opening a browser and surfing a bit. Let
> me try step by step without lockdep, without RT and maybe just play
> v7.0-rc1 to figure out where this is from=E2=80=A6

It triggers without lockdep but takes longer. It does not trigger
without RT so far. I will try to narrow it down later unless it is
obvious where this is coming from.
=20
Sebastian
