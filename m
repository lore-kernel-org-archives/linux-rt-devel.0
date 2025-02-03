Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3771F37B8
	for <linux-rt-devel@lists.linux.dev>; Mon,  3 Feb 2025 16:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738598468; cv=none; b=NY3RPMOebQ9oc80jn2n335BmWKLvAwvoEB2Qk1Mk2TgqsNW9fk959IPCmNPEsifuXYNP5VyGVEsyegCkD+fZK1VZE7aJi3iYBVma9t4WYZ8rrr85P97jgtnBvd2WKx0DI7aRyonRc8B+zA5oDrAkmg6YtmYjDtMDX5/2y6HHFiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738598468; c=relaxed/simple;
	bh=avDciMr/EFBEDxlRSPXIiSAyoliNJHuMQZ86rj/N8zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qciR2uYv+N03Z2/ljBH8rLVbQrHVa8L4gm3l08bv4vTwHqFDhAz5NbUKLqxHMyRRXDZkpWg0ELZsGVP6EJ9+YWT3K30NAHLF/y2/iI8PSKVYuR7Vd27MlKfSul7JpVkInxQBdqDn4BEJlu486K5GQqcTo5FJhfDhkbOTSbGoSss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xGuLoozb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XRtrY5YO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xGuLoozb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XRtrY5YO"
Date: Mon, 3 Feb 2025 17:01:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738598465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=avDciMr/EFBEDxlRSPXIiSAyoliNJHuMQZ86rj/N8zw=;
	b=xGuLoozbF4KHQ3PON6wkF9IECWn19hd4RkIVYP4jhCwHEMfVSctwTZblRviSE/w91BBFp3
	Ozi3YOoiouoUhH8Fd1Mz6HRETW8SaAAmPGpbedvuvJAgWSgORmxvY0WHi0WDFWf7xowFej
	kE/gwSPTcSJa6bFSOUjRlEXOgn9vg2ZkmTCWcvWzNo0uoIXPdvuRXAhQ5MnTjkSBekoDbI
	jYy+L5dq1F2f2Cze6AUE4Y1ItGE7tWgy1Uzfi6vrCnDCLQLdtJkDVRvNfqRq2HIm+96+2w
	9MEdk/e77irY2rLQqjXO+XA+lU+TYfz+670UrH7h10FC2hkhceBgvV8pW8GUFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738598465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=avDciMr/EFBEDxlRSPXIiSAyoliNJHuMQZ86rj/N8zw=;
	b=XRtrY5YOugetpsTxeoYN5FcxzEoVQBmvYjstq9XGiVkR5vcsRa1yOoUJWrflh/S8hVOLVI
	IN05R/ArjKk5MUDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
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
	Will Deacon <will@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 5/9] powerpc: Use preempt_model_str().
Message-ID: <20250203160103.9DikC9FJ@linutronix.de>
References: <20250203141632.440554-1-bigeasy@linutronix.de>
 <20250203141632.440554-6-bigeasy@linutronix.de>
 <65c6f60d-bb52-48bd-a02c-87ffd2a915d4@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <65c6f60d-bb52-48bd-a02c-87ffd2a915d4@csgroup.eu>

On 2025-02-03 16:19:06 [+0100], Christophe Leroy wrote:
>=20
>=20
> Le 03/02/2025 =C3=A0 15:16, Sebastian Andrzej Siewior a =C3=A9crit=C2=A0:
> > Use preempt_model_str() instead of manually conducting the preemption
> > model. Use pr_emerg() instead of printk() to pass a loglevel.
>=20
> Why use pr_emerg() for that line and not all other ones ?

checkpatch complained for the current printk() line and this looks like
an emergency coming from die().

> The purpose of using printk() is to get it at the level defined by
> CONFIG_MESSAGE_LOGLEVEL_DEFAULT and I think it is important to have the f=
ull
> Oops block at the same level.

Okay. So "printk(KERN_DEFAULT " then.

Sebastian
