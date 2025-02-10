Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A6822068D
	for <linux-rt-devel@lists.linux.dev>; Mon, 10 Feb 2025 12:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739189191; cv=none; b=L70aj7KpgB42Juttg+ikQN4JYi9/BfVAGVn+yGobMddmbqGj+eNSM/JYZTgi6IbkbdNO8GECtqbYWWP+ldfjeDNZpEbb3qnxjmFzUN2HFhhFD8TKBRL9vJS3cb9ZGOXNpm/NFDuyW1jVLZsmSDQmNraka9zCpHLKl+/nuqKoEDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739189191; c=relaxed/simple;
	bh=H5c23d9e/m7VveiOFBzA2gzMxqciYhqAmG4A2quPJp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/EwB2yZJ+k5q67oQxCAndnkrDUVvrF0v6wkz0pMoLeYJDDmr9bHJgU7eOZzDfjSeCBkTDzphBjdojpFkZf4RMDrb6JUIDxT6szy76MiAWXo+ZfZs3RNkfyB8frf/01PwW6DuYuJz25QXygf5TSF7kT7IHoFkmrLQcTSS05bCd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=awVn53XD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xIInMNod; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="awVn53XD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xIInMNod"
Date: Mon, 10 Feb 2025 13:06:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739189187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2mynsei9YosbBjePqOYbXOxcLMlabRINg90zzUmsPO4=;
	b=awVn53XDZRY0RLPVlviskbG703fT2Lfh8BHbmol1LEW/XHPc36+0ALXZuA+4gEIWwhef0h
	In4PLDL1RdfVpR3iQcIpI38Q5zgvMXE4B0jGdvMOCkrmKk8k8tc+mt0xjvC4vlO/fWRbR+
	tnTXEjoau902SGo/iwg3Ub4/LxulLfK5qS0mmzT9OIw2mCMrskEOr1Wa9byvmEU7YlTPjR
	9C35O0tHzCH7B4U1YcJHsOkVJJKFVoqUo+rzBFK7F3m4G8mY4Wt9DRM3jvXyvC/+vJiGTC
	s1v7xMPo2zAGLcsp6SleGcRTYO45+p3WOnkPpU2AFlVYm4uRaCz8I7EG9Xy09g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739189187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2mynsei9YosbBjePqOYbXOxcLMlabRINg90zzUmsPO4=;
	b=xIInMNodOdhcYWNE9Eyc7N6Tjdp2K2PsYW2QqZeduEJXoO462vHDFet8N98d6s5IXPuzJM
	W/FGeSijdonuuCAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ben Segall <bsegall@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Will Deacon <will@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 7/9] x86: Rely on generic printing of preemption model.
Message-ID: <20250210120625.nNiVxgOJ@linutronix.de>
References: <20250203141632.440554-1-bigeasy@linutronix.de>
 <20250203141632.440554-8-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250203141632.440554-8-bigeasy@linutronix.de>

On 2025-02-03 15:16:30 [+0100], To linux-kernel@vger.kernel.org wrote:
> After __die_header(), __die_body() is always invoked. There we have
> show_regs() -> show_regs_print_info() which prints the current
> preemption model.
> Remove it from the initial line.
> 
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Is it okay, to route this via the sched tree?

Sebastian
