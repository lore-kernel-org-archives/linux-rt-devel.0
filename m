Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AEE2FE041
	for <linux-rt-devel@lists.linux.dev>; Fri, 24 Oct 2025 10:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761302379; cv=none; b=jsF5ABRhwsYy3Zfbfz1JF9joIVj513wUrJ69BffDK2YSKpjQz3JjDSlA52U8qRMERs/yWyI1L1CONGSvA0k+/LyFNPHKQyiLwDel/ss7GrLA5MZnVgzXNHFi0MpzMTl+nL0gff8FwZmnQN6EY3RoVSieEYCsJkX0z9j7D3EqggM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761302379; c=relaxed/simple;
	bh=UdnRgrYTxTwl0NXXAxGaXi07cSp6W24Rw+s0+3JFWxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1QBfvNO5v2ge8rm0r6vEI9O3X1mKaRkYTfMRKaN4o0Nn5reXLotQOUzM+Kv+q6NHq4AmHd9E204fHHgO/pAkqHNPD9rwPHP1BtsUeiW8lfP8XEmNTuuL4azJmPRZACq8a5He6E1PVgeoz320VdaKLSjG2BPQcxVPABxLw6oqdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DPNgntTI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/ozyMPmB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DPNgntTI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/ozyMPmB"
Date: Fri, 24 Oct 2025 12:39:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761302376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZbvWP/ULZdr1H0B0DeN80d2jKGeA+DNTXiKQK2cKlBU=;
	b=DPNgntTI6+fzLAJ/QDXD/aTKfn7UQyuK5TC0c9/8hWxaDteyt67uRT8ueVGJRp5/tc/zu6
	AAqhKtGnH8O/B839lXDeUnUfPEx6I5JDIcaB7jcibH90nLK6/hD23lTmzz45mP6ix3uvW/
	TVao8IVpTkVmB8o+ODgOYZqC9BWVzsPVacc8XgklUj4Pl8ns5W/hrK8YQRNri02JbO4gyh
	iFItEtDzTI2fSI4bsJAQkeWejX5/y+uYYYjoWrAEe7dLtDXi6WfGKM0wBv+gxuREvgaRY5
	jgSrWm5c8WSWS4W37+GK7JOyUDyqHDsQX0NO8G3O9crcMLCnBdzn/dlNMZrvBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761302376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZbvWP/ULZdr1H0B0DeN80d2jKGeA+DNTXiKQK2cKlBU=;
	b=/ozyMPmBFI912hHmPcAHZVCOFdFeMXBh5VFQeYrIgstEV0RdKlrzUCpBu2QSSli+zbNHrQ
	x/XSI024cm2Kq+CA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Oleg Nesterov <oleg@redhat.com>
Cc: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	David Vernet <dvernet@meta.com>, Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>, Crystal Wood <crwood@redhat.com>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Juri Lelli <juri.lelli@redhat.com>, Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>
Subject: Re: usage of DEFINE_WAIT_OVERRIDE_MAP(LD_WAIT_SLEEP)
Message-ID: <20251024103934.n4Lx1b9O@linutronix.de>
References: <20250729130936.GB18541@redhat.com>
 <20250801102428.GB27835@redhat.com>
 <20250811105948.OafBprND@linutronix.de>
 <20251020145310.GA9608@redhat.com>
 <20251023135316.1ZRx0UU5@linutronix.de>
 <20251023152942.GC26461@redhat.com>
 <20251023153750.C6EU9NL6@linutronix.de>
 <20251023155339.GE26461@redhat.com>
 <20251023192353.Wkng87fi@linutronix.de>
 <20251024102616.GD771@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251024102616.GD771@redhat.com>

On 2025-10-24 12:26:16 [+0200], Oleg Nesterov wrote:
> > | /* PREEMPT_RT kernels map spinlock to rt_mutex */
> 
> Ah, indeed, I was confused and didn't even bother to read the definitions
> below, spinlock->dep_map is initialized by the same SPIN_DEP_MAP_INIT()...
> 
> Sebastian, thanks for correcting me! Sorry, I could not carefully read
> your emails yesterday.

No worries. Just let me know if the cited comment requires an update.

> Oleg.

Sebastian
