Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E559535AC34
	for <linux-rt-devel@lists.linux.dev>; Mon,  2 Mar 2026 10:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772448849; cv=none; b=hWRyTpZXX+hr+l7UluEm8w4DbvNdGVPPKz/JVAc2hBsm+PcjMncUIMpkfqnsijqNRi8bQIEsRkJB1/3PI/Of0iVpnxQJmxwj42C/Y4AdNd6Vv7wlynWvmISe0fU6yojbPX2rVy24lKhXKwB68GnFOVY5UtxXcP22bmdlQnKLUC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772448849; c=relaxed/simple;
	bh=nqr7P2AXcIfPv2TTpdlGMHrXcRLz51EfYCSVtq5Pqkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDEjXT6d7a7n2qwmoJtuN/dvLXLhF6X3E8f8Y+YjGR4CdEUOGMgu0h3OVU+6/3v2e0xqwA289E+keBTM+BpoCuKRC70mm/zHbP3Z8P++RQALXvTFfARDjLQlDXN7jS63SSUzFWPoSGy7g05wfw5vkcjG4cWMtF4qcFR7+b1yppE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jD3oAQej; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TexzpHjF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jD3oAQej";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TexzpHjF"
Date: Mon, 2 Mar 2026 11:54:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772448846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uDPdb9l408UW2dK8RDYDN3+fzmDd+VUlaz23BOiaXGU=;
	b=jD3oAQejbS+X4o7pXnOD9SU0N080OPn7NoiIA9oVFHBYkL4elZGd5JIb5yRSblXDwckUow
	1S+rNs/cRLzHUueRZu5TWe3J8FSoOFtO7C7BPSad0UMoSI9DVuH9LTQoT3vbwRDLUUelNK
	xbwLeDlbcPNOeQKmlkGlvHzpcIyhCkvSAyEb6hTc1DJlrXiFIJ+7RMgNxdhs4JfCkq+KKa
	HIH9k4vidPvk51PjussL3GkBZEKi9HhmWiW4rrlR6viyGVywKIQmo7W8CU+z3C5aAQyM2H
	q/JwNoN+783EXenoci3P7MD14nbdF0DS0uKp5RZxG7FUEBejbeBCw9L8TYHkLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772448846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uDPdb9l408UW2dK8RDYDN3+fzmDd+VUlaz23BOiaXGU=;
	b=TexzpHjFRCZAya2R5oiE1nlJRjCVIQFKzu0QNDERBwrBW6jl/8qwmLwPC4nAG2KW1Fn9fj
	oOvKy83hJh14X4BQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org,
	Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 6/6] ARM: provide individual is_translation_fault() and
 is_permission_fault()
Message-ID: <20260302105405.zTTpLiRj@linutronix.de>
References: <aaG1wrNUaq_L0I5g@shell.armlinux.org.uk>
 <E1vvzcs-0000000AwoO-03iq@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <E1vvzcs-0000000AwoO-03iq@rmk-PC.armlinux.org.uk>

On 2026-02-27 15:19:34 [+0000], Russell King (Oracle) wrote:
> Provide individual LPAE and non-LPAE definitions for both these
> functions, rather than having ifdefs inside the function body. This
> places the functions closer to their associated definitions.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
