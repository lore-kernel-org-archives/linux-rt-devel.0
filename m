Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE53253344
	for <linux-rt-devel@lists.linux.dev>; Tue, 11 Feb 2025 15:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739287276; cv=none; b=JJK88i/XUOVeDNgBgnjhCvSPfVEQvRImcLelTBg3D6RAN9f5jBfcJAuA581kSG/WlbuhGDTw0XNGmeHhgeDB9ocrZPbKzdC3K0Jq9VHdD7jwF+wu5Zre7GE7dogPW6Ks9J3B9SuU0+1Rm8lLv81vE111kdd7PyNAo45AH3Xq6tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739287276; c=relaxed/simple;
	bh=qKQuCJ4+PDxAUPnVD1YZ3ker7qZu/gjsp1E1/r6v2wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bk9VsEJX86NyooXWFiVBPN7yqfk5T07YIME93VgR0RbHg3butaYgiywT7sixN+jv7wIgQmK2PFxARdn1iGEk3b3Qi3FRg0XIAbfCxI78WG2hGUndXswLvZUgRvREipmdy6cvKz8ZMGqU8jRALfOpND5F+q5bHg2YfPZL2KkiL8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zv4U2Mhx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yacAYOQ2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zv4U2Mhx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yacAYOQ2"
Date: Tue, 11 Feb 2025 16:21:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739287273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RAfehH0pRSNM74jOU1hpoGaCaoR26ZlkzhoEyncNpPk=;
	b=Zv4U2MhxITSl9kUmmsVJW4c7qLimnsYlmhKut/KZgg8KnpnY2nxZSpOCX5SzEn4xIVeyi5
	BbKOZMuUnKJg2l7HBSfZfHFrsKavpg6Vm6qjop/0AiVHTwpFa/qyhgBBsnk6OdXoXd8+UI
	FcIMyUkv8d9RVvo/fEUUklKAn+FUi0oDYjAEGNUvXeLBvxdSW0/K7gUaV5N9bvlCqoq2HL
	D68LXsa2ITeGyFN+RupkGKCuKWTJ1ClPdEivuq4hxcQGKRvnfPUpsUt+1udKOBvZ9Rlq7K
	ECtda2ldgr6Uves9g1Q80JVp4Vf/XDzsY6Pzf0o0BgiJyVmhvFpVkq3jtx0PhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739287273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RAfehH0pRSNM74jOU1hpoGaCaoR26ZlkzhoEyncNpPk=;
	b=yacAYOQ2pG5/O3bhi/OUOrdcRl3g0N9/LAIUyWwUai9zxXqq3tjoYPi7e9+nqF8HAo220z
	yNmtetUKNh7IQfDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Ben Segall <bsegall@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/9] arm: Rely on generic printing of preemption model.
Message-ID: <20250211152111.A6HxeZLd@linutronix.de>
References: <20250203141632.440554-1-bigeasy@linutronix.de>
 <20250203141632.440554-4-bigeasy@linutronix.de>
 <20250210120429.iFfBClW1@linutronix.de>
 <Z6oYO5uKlEJ8C8Ne@shell.armlinux.org.uk>
 <20250210153902.06VTSS6d@linutronix.de>
 <Z6oo0MExaEy5J55_@shell.armlinux.org.uk>
 <20250211145249.StI6tEZv@linutronix.de>
 <Z6tnQvIBlGnoGRN_@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z6tnQvIBlGnoGRN_@shell.armlinux.org.uk>

On 2025-02-11 15:05:38 [+0000], Russell King (Oracle) wrote:
> 
> Got it. Printed from __die() -> __show_regs() -> show_regs_print_info()
> -> dump_stack_print_info().
> 
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thank you.

> Thanks!

Sebastian
