Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFEA3590A4
	for <linux-rt-devel@lists.linux.dev>; Mon,  2 Mar 2026 10:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772448694; cv=none; b=Vwz7mHWW84i4gxsgrjwvB3WwwSUE6JQnuSPWokip4urFShbaVebIod4aKQdML9F4UhdXrygt/bvt2n7kCLvLQKEdswm0XovhbMMDPMEqbvFFH2aJna74yCMU0vUz7/6ZcB0+AqPryfmJ1KNzQ2j7i3OxkW3zlXln9szAymPKOzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772448694; c=relaxed/simple;
	bh=gungxojt1JLveY2mcJNznXl62fn97xjVqtkUoY1ICuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwn/Z5DlOTNbzXAb98MxfbzJZMdSkP3ENe1pqMYQnDQWswedOGTpxfLAeN+usTAoQeXD7nH3V98uHaavL7LZQvQ7vTaRxPHFJS00/4109wi0v33giiFaDVeVJMNahYG+h89yZnm4Frm2RQlSp+PToJkHqfJlBP9lAcYexj6IP3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wc8u8Prl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vx4CdNhr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wc8u8Prl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vx4CdNhr"
Date: Mon, 2 Mar 2026 11:51:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772448691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L0KCOyoLsIgluS1BqRcipX43WxCPDJ9M5ANAEO2kJJQ=;
	b=Wc8u8Prl3V1HRW1Zg3I5vIkZuDQBxfUEbq1gx/0/4I+XZnctpr3wF79l36Gg3VnsHNdWM+
	nxFEa7MjHVYkIvs60GtH06Gsjw0HtMvzm5eJGTe8JZy/j2B6ccTqO8kj2puYZKx7RMP4sM
	DzLc+11eZWb/PAfjawTcJTXa5gS0kiAGobNAPKoRAQTXDy1KUwfREdXlRcib0/K70IBabW
	CUgZgmgsXGctxjsnWISXVIazy7LzLRNhB1gr3GipWenfIddFyHsNCYOyS+Wh4VE9BmmAwk
	Xz8l6iCAKXerxFVMRPCCC620s/v702sEm3We/Yd/0G1fBvBDBzy9Tq3vz5Tpcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772448691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L0KCOyoLsIgluS1BqRcipX43WxCPDJ9M5ANAEO2kJJQ=;
	b=Vx4CdNhrM/2/EmSrNiFcTRzywLsJxOtg2qh/Zl7BlpSVXbrZR6mPP+hUCbwMEdCr7tdTRA
	W2XRoy9gJLB4G+Bw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org,
	Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 5/6] ARM: move FSR fault status definitions before
 fsr_fs()
Message-ID: <20260302105130.HTs-UDqx@linutronix.de>
References: <aaG1wrNUaq_L0I5g@shell.armlinux.org.uk>
 <E1vvzcm-0000000AwoI-3o9W@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <E1vvzcm-0000000AwoI-3o9W@rmk-PC.armlinux.org.uk>

On 2026-02-27 15:19:28 [+0000], Russell King (Oracle) wrote:
> The FSR's fault status bits depend on whether LPAE is enabled. Rather
> than always exposing both LPAE and non-LPAE to all code, move them
> inside the ifdef blocks dependent on LPAE to restrict their visibility.
> No code other than fsr_fs() makes use of these.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
