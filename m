Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908053CCFDE;
	Mon, 20 Jul 2026 08:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784536004; cv=none; b=SXtFkEjTbFExB7ZyUcGtlrXA0nbXiscQNs4w2lCF64rZN1TXIB12t+1TJ55HsRbDzYQ+CRFCAz5b6gCm68PyC4Cz9rcUwd4l30HR85PoWY2GU+uvPrPUVgkX58xL2WyxOhN1v5DvQJ/Na9mWy/hndMquW85c9lZR+BXN74inwxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784536004; c=relaxed/simple;
	bh=j0Borxxvhvem99u/HnwMB1jt9XIHiH2uNdy1TpQ69mE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/LeQufKJnDBicLU6yV0BSkz9BgIL7VHgbePxXwgPbyFWbW31C7oy20ExKHxFTPHH3KwTr9x4ep7mmvXfO5SOPKh9n9OEZHCEfYaskxO4rl3tSLt0prFYDoguDHHn5hIW7cLZk3fgkbVx4gJgRfJnlfOhl3/T/hSJFRCLnAF56Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sgIOyHNr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pYgfH4oP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sgIOyHNr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pYgfH4oP"
Date: Mon, 20 Jul 2026 10:26:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784536001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j0Borxxvhvem99u/HnwMB1jt9XIHiH2uNdy1TpQ69mE=;
	b=sgIOyHNrGqO8erm1oO7x+6iI+CwxM26U9BlWkXaU+txf0bG46GiZn/T4jP/k9IJks1tImQ
	FVjgttM3Fe6QB3BIfm0c0vHI0psv78VUSSliHE5neEPj1+CV4u+goaQJEOnaPLDDuYJIlR
	H23tU0XtRbvn07LjLo5Hk1SgXnJX5ZQVd2WvN3NEdjMes0Zvx9cgownS1cmiT1+Llj4C5j
	WQhosYVtisdyRkj/NGzMwwP/ErayMp8vMSuU9bbGtRi9w17bS66Hg/81XDQqAj79FWB2yH
	hN1uqcoBWjESCzagAO3uhvXCXjW/ptQp+y2pcQkQDI7SDUkNpHrqOyyM95wiSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784536001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j0Borxxvhvem99u/HnwMB1jt9XIHiH2uNdy1TpQ69mE=;
	b=pYgfH4oPnLAZ5iJOE0lhpgm+6JakJNk+oO3zJgp0G1IHdXjsLZltz0dTdk2+YgEFS9GCFk
	05X/0vR0AP35beAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: John Ogness <john.ogness@linutronix.de>
Cc: sashiko-reviews@lists.linux.dev, Petr Mladek <pmladek@suse.com>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 2/2] serial: amba-pl011: keep console clock enabled for
 atomic writes
Message-ID: <20260720082640.eGsVn61E@linutronix.de>
References: <20260719063502.18852-1-kmehltretter@gmail.com>
 <20260719063502.18852-3-kmehltretter@gmail.com>
 <20260719065214.A40521F000E9@smtp.kernel.org>
 <20260720080100.Mk9zZFql@linutronix.de>
 <8733xeaxix.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8733xeaxix.fsf@jogness.linutronix.de>

On 2026-07-20 10:19:58 [+0206], John Ogness wrote:
> This is what the suspend/resume pm callbacks are for. In this case, it
> is pl011_suspend() and pl011_resume().

Perfect so everything is in place except for these two.

> > There is also this no_console_suspend argument=E2=80=A6
>=20
> Yes, the callbacks need to check @console_suspend_enabled. If false, the
> clocks obviously must not be disabled.

good.

> John Ogness

Sebastian
