Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF3D21148A
	for <linux-rt-devel@lists.linux.dev>; Wed, 12 Feb 2025 17:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739380200; cv=none; b=NI1HE/Purmk9CVZljAvxssuDzHrqoQ45yy1tNFKh1NpJF6sZE69UwOlb/VrCHw1A8YfiGMvgZ5Tpx40pJBbhFnrTxdox50j376l6N17A41sD+Lovou2NcR9EjQhtNttziCzKqbK9DcmfffhGbePCTAphiv26fe1C4JFDhRcQTQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739380200; c=relaxed/simple;
	bh=xZ8GpICaaA+rkbmbCmveotGOQHo18cdC7YQ7HvUrw7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GzJ3q++23tNNLvbkvBC4IPyMnUynSnwdJB7JFJZ+W7zEwrXDRJKRI3QozbUh+8Xu4YaGp6J5OMZ6XYFB2lg/pqrOmCp36B/qyUEY/gtWo05lUMwlCj33IdvoOfEdHK/8350GE2Fv7mPXC0Vioy0Ui3i2ZE+3WSkuMYGmuO8knJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BKKtWQsb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SzZPOo6S; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BKKtWQsb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SzZPOo6S"
Date: Wed, 12 Feb 2025 18:09:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739380197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i4Ge3+NaBQUjdCmMAkepKnrwvSCgb2tugQ6RPhwpH8Y=;
	b=BKKtWQsbZ0TZ4IRLKCaVMG7RmQKmt45+ZSapIV/llmERFFVcSQm4ef0IUjupdM5NtSZ5Os
	duM3rCxf/fimk/i4q61xfHaSDqv/VCjuv4/HDA5WgVhbeo+/1wLMJ78yEXn3cvO+TKfHsP
	cwAu58Kqcn705QC3U2pDFJR+OAamUB1Gq/arzP2u0SeTby0jxprzNCpDSki+rsQ9uxa1zq
	WXUW1/gQjpjr/LK8pF3aa1vlR0Fb38br81ezVbySW1iFO2EewMtpkOVIrQ9OTkRdhIuRRn
	D3kPOO8d6TMaglQrud3BzZyE1nA9sC8V9IdXsJgTTDDaROl0ToyD6pXN6DBy/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739380197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i4Ge3+NaBQUjdCmMAkepKnrwvSCgb2tugQ6RPhwpH8Y=;
	b=SzZPOo6Sk5hejFnx3W6hUjmjwr8PlF6Nvmdvc6/dlHss2QWHSyvV2HF06jQBxlBpVnYDtB
	3Xrfs2ax8J5N4yAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: possible circular locking dependency backtrace seen when
 enabling PREEMPT_RT
Message-ID: <20250212170955.x1oRhNjr@linutronix.de>
References: <d9480845-7e81-46a2-8bbd-bd0ebdbc6a5f@roeck-us.net>
 <20250212114531.4e95ffe7@gandalf.local.home>
 <20250212165908.DoNnHJ5v@linutronix.de>
 <20250212120328.28fe4123@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250212120328.28fe4123@gandalf.local.home>

On 2025-02-12 12:03:28 [-0500], Steven Rostedt wrote:
> On Wed, 12 Feb 2025 17:59:08 +0100
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > On 2025-02-12 11:45:31 [-0500], Steven Rostedt wrote:
> > > 
> > > Shouldn't the spin_lock_irq*() variants for PREEMPT_RT also disable local_bh?  
> > 
> > Better not. The consequences sure wouldn't be funny.
> > 
> 
> Why not? It keeps the same paradigm as non PREEMPT_RT. Do we really want to
> litter local_bh_disable around all these cases that spin_lock_irq*() is
> used to disable bh?

Yes.

> -- Steve

Sebastian
