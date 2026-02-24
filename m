Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDCB39C62B
	for <linux-rt-devel@lists.linux.dev>; Tue, 24 Feb 2026 14:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771942547; cv=none; b=IN+3mvMICtlQGq12uToHicotKqVskTLOgorItZ1sNpinC0eaLa3IdpGmh/r4RmcKteJOcDwvUVlvCcnjWHJjdCJwgtqSISGCYBsaKrih5BNSqZ1zx4i/+ul8+cyjqpeeCQ+J1iUvA5Lz/OyF/dY3lJ3exRNFEGpUFkU+ZW6XBYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771942547; c=relaxed/simple;
	bh=dNjYeM6hGv29WKg9kWtLMN+jylLCTcklCbR6s8aADa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsikMHg3gDRETvZhOFFBTZqad7Xj/2t1Cx4O9TiiYa0mg08i7bzyUoSmfV+ZGjcL0SpjTeqVdO2ir4f79xlr6jJsEhiyTmqYzCv6NQ5Iatekvm6GiPSDgrcoLPxqtoRB0TxMRdpC/YxkAWajqtDSTgzSxSF84SvUwnid1Y+XHlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O+8vHw3G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SmxFH0D4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O+8vHw3G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SmxFH0D4"
Date: Tue, 24 Feb 2026 15:15:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771942544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dNjYeM6hGv29WKg9kWtLMN+jylLCTcklCbR6s8aADa4=;
	b=O+8vHw3Gs8uRydlSqYfu9x2XLKlANTrfVM1Q/H2ZyTV0vrs2DFan+nNsqofOL/LmqJLXAM
	1yrRFVImChO6kNDkVxwLhXmAusOaNjJk7wFN7OE2S/puHKCYWb+zEK/WbqLbDYBVjPSR7L
	o1J7QLgzh+I5kObHcEtTkbA7+hLxNxLzKzDH9+4HdqUSDFF/n6r/mYgW+2hMKxtmDcPgub
	uSyTiNRkalGS0CzzSY6aKt1m6ziaZi61jFYUEnknUNOga0nPq4NwepUacda4KX+MoJzHQK
	fhjj6XhabvPIWaejFSv/ctdH3rfDO5t4qCdKXX/NPDfaJaXKHUqDwz9hjdV4Xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771942544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dNjYeM6hGv29WKg9kWtLMN+jylLCTcklCbR6s8aADa4=;
	b=SmxFH0D4T4i5DkM1Skr6VX9HCGXcn+1/b1CcRsM9dVfwNt/7OU9p0T4SyCv7c7Skdedqcj
	Grq9uKXvgF4VRTBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	linux-rt-devel@lists.linux.dev, dri-devel@lists.freedesktop.org
Subject: Re: [i915-rt v6 24/24] FOR-CI: bump MAX_STACK_TRACE_ENTRIES
Message-ID: <20260224141542.cDL_xEWb@linutronix.de>
References: <20260220083657.28815-26-dev@lankhorst.se>
 <20260220083657.28815-50-dev@lankhorst.se>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260220083657.28815-50-dev@lankhorst.se>

On 2026-02-20 09:37:22 [+0100], Maarten Lankhorst wrote:
> We're hitting a bug in CI where MAX_STACK_TRACE_ENTRIES is set too low.
> My guess is the repeated loading/unloading is creating multiples of the
> same entries. As a hack just reset lockdep. This might only be necessary
> for CI + PREEMPT_RT.

spinlock_t on PREEMPT_RT uses the rtmutex which from lockdep's point of
view counts twice: The "logical" lock and the inner wait lock. That
makes twice as many locks. I hope it is this and not some accounting
error=E2=80=A6

> Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>

Sebastian
