Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5BA421F00;
	Tue,  7 Jul 2026 13:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783432207; cv=none; b=antp0rP/LtBj05r51qSOrbtElOMECiMQnIMHj1ZWI9sdr+50Z08qJFO1k/hWNvaRQWw2HbmZfFaroQ+RgfeRpVbhstjyXOQqYTJD1wXv3VI2qBxl8qVa8AcMXcrS/+RAVIHpbGQQ68rYt92VKUg1wa30ouzTb0bBiQLbmcjSEVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783432207; c=relaxed/simple;
	bh=q/1713FHlDloKU+P3UhkTohcYgghs28y3PCWNpu/DZ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M5fzS2qYB8ARABv49iHopzLyCfBQ2IYkiAjXu87BJ/398lkpRJT7HmwvbIywftu70S9ha/lr99gVKbt5l52l2O+Jxnq8tr/Fzl8JQeGMDqZ7ycASNvHGRKhp4CIVOUXwIosEj7lhyTgMQnjjqCRuEP9Vtw5qiBNr9nGQ3NFTalY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EL18uPI5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p0Ldbksm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EL18uPI5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p0Ldbksm"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783432201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q/1713FHlDloKU+P3UhkTohcYgghs28y3PCWNpu/DZ8=;
	b=EL18uPI5Xdsmw6WWUBiUP9SMKaw3dNPSANAqQTiM2m2QquzjrlmrNNsrtznI2b36E7yIzq
	auXKFQy5pUCMgVSNo7J4x2wxXG7+k6SVwrGuWsJ5OkUu0aZRQSMGO5jPxiOqePm5tTBBlo
	UPoCKeEeE/c5NQtb7DK9lRIj8kEx1vbBjgmIC3gtfbPUUYDU4uHqXKTSxYFdlSF/N3DKkE
	BioWWGR1CfPi2ImST9Xk86ItFzQsw0A1OPbxy4+rIB2fguN3bpD+ekqKtN60by50Ne/mN1
	uQYCaeRhaRNbm6Atzdauvjw4ZJXIVvKOq+fibGkMJv/TwT6PsMbpkzjglZ10Mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783432201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q/1713FHlDloKU+P3UhkTohcYgghs28y3PCWNpu/DZ8=;
	b=p0LdbksmmtnmoaDRv2u0EgJQwkIU5teucrUlqMuNF42/BhFfgkf4P8nZHKeW0l3g/uGvN1
	fCSmsSRTInV3VEBQ==
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, sashiko-reviews@lists.linux.dev,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 1/2] af_unix: Do not wait for garbage collector in
 sendmsg()
In-Reply-To: <20260707114225.4oj9SF_0@linutronix.de>
References: <cover.1782922354.git.namcao@linutronix.de>
 <e663a83195f3d9f6d7ad4907c37ae3e45c151062.1782922354.git.namcao@linutronix.de>
 <20260702163608.0207A1F00A3A@smtp.kernel.org> <87mrw8sjo3.fsf@yellow.woof>
 <CAAVpQUB+LDxRrF66=NKwLAdLN8kt+Hssm_KBc2oc_q6FTJF0VA@mail.gmail.com>
 <87wlvbmgtv.fsf@yellow.woof> <20260707114225.4oj9SF_0@linutronix.de>
Date: Tue, 07 Jul 2026 15:49:59 +0200
Message-ID: <871pde3o54.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
> On 2026-07-04 08:03:56 [+0200], Nam Cao wrote:
>> Kuniyuki Iwashima <kuniyu@google.com> writes:
>> > your patch makes it much easier to abuse.
>> > UNIX_INFLIGHT_SANE_USER is usually much smaller than
>> > RLIMIT_NOFILE.
>> >
>> > unix_schedule_gc() in sendmsg() is to self-regulate malicious users,
>> > otherwise GC relies on unrelated AF_UNIX socket's close() and could
>> > be triggered too late since GC is system-wide.
>>=20
>> About the abuse, the scenario where inflight sockets bypass
>> UNIX_INFLIGHT_SANE_USER and delay GC until an unrelated AF_UNIX socket
>> closes actually exists today.
>
> We don't bypass the limit for an ordinary user. That one gets blocked in
> too_many_unix_fds(). But for the CAP_SYS_RESOURCE + CAP_SYS_ADMIN it is
> a different story.
> In that case we cross the UNIX_INFLIGHT_SANE_USER and schedule the GC,
> it is not delayed. The worker is triggered regularity and the thread
> waits for its completion it is just the GC worker does not clean up
> anything so it continues to increase. The only thing that actually
> limits the sender is if it runs out of socket memory and needs to wait.

That's also my understanding. But tasks that have
CAP_SYS_RESOURCE|CAP_SYS_ADMIN should be trustworthy to not burn
system's resources.

> So it kind of works for a single thread.
>
> =E2=80=A6
>> To address this properly, we can schedule the GC at task exit. I can
>> include that patch in my series, if that sounds good to you.
>
> task exit or closing the socket?

I meant task exit, but closing the socket also makes sense because that
is when dead cyclic reference can appear. However, unless the file
descriptor's refcount reaches 0, the fs layer will not call us. We could
change fs/, but I am not sure if we should invade into fs/ just for this
one.

For the "resource is still consumed indefinitely after task exit" issue,
then scheduling GC at task exit is good enough.

If the task does not exit, those dead cyclic references can sit there
indefinitely. But this is not really critical as it is capped by
RLIMIT_NOFILE. Additionally it is impossible to prevent a "malicious"
task from creating RLIMIT_NOFILE inflight sockets and just leave them
there.

> Either way, in your PoC it hardly makes any sense to schedule the worker
> over and over and wait for it since it does not do anything. Sure it is
> the system as a whole so triggering might make sense but I'm not sure
> about waiting for its completion.

Agree. For the GC triggering thingy, it is a trade-off between CPU
consumption and how early garbage gets cleared, so that can arguably
stay. But the waiting part has to go.

> Side note: gc_in_progress is redundant since you can't schedule a worker
> twice and work_pending(&unix_gc_work) would provide the same
> information. The only difference is that you avoid scheduling the worker
> while it is running but I don't think this is a problem.

Yep. Additionally gc_in_progress is not read/write under any lock, so
it is possible to read a stale gc_in_progress and the GC gets delayed
indefinitely. That is already on my todo list, among a few other
things. But let's get this most important piece done first.

Nam
