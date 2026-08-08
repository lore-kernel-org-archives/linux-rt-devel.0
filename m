Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689CE2853E0
	for <linux-rt-devel@lists.linux.dev>; Sat,  8 Aug 2026 04:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786162067; cv=none; b=DWtKooJ6ysgv3AGCNNZKxb+C92DLpzMcg/dV7QA3HooDZ8TxEcXyPT7WlLgGB9+e6yIJSlkyluaQVrorYQvGgTV4b3jESNn9miKhjiJixQ/0h65NAXuim5M9M97fvg8DVP0mWISPRZxTOd3egxB434t4hs3jLKnh9yU12Lkkqzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786162067; c=relaxed/simple;
	bh=BxNVx5ZtnGS7GFwQB0HTUTtRFp0naCVUZiFxqXSIK9c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EeiXd6YiX3xYTnd2s8vkAVKINFIiTxDWbdKG89DvVixiWVCu31LBy2rBfzee/6eSGbl67+eMq+klh8CmaZtPxREaPL51C0cJ+MdVvyINjeTHf2y6tzwkInbkf9/+TPnn0azEiFdepePwojYzdEvt9+nroMzoEe2raD1w8uK1Ub0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aDGD2rci; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3qYaC7C0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aDGD2rci";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3qYaC7C0"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1786162063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=daUV1+wGO/CYeDnloHPgUaZDWTkRssQTwTJKBeZ1esY=;
	b=aDGD2rciRD3r/Wjd77SJJR7isE1fjfxa6e75kY+eZ1Bbn71VEkT7Fuvhis/VXsVI7cfdNE
	HDuBy1hFxz9AkNSB47cT2qE39Pw0FY8XoZosf1bKQeHcVThHF922odNoIP4g8ud+Cvl4UT
	npgZ+Fa5RP0mN0ZhhlQfPdKv5qQsVOdFOIkhlSbpugIAB9LhCUKlz7GKh/UtBsrwb7QR+m
	AlT1uxAXBPGvu2h8PIJsLo/EZfe9pgp3Bi4K99ECtkZ/1fit6VY2xzycakCpNqcOKr8vlb
	mYmgQdQmRRN40je7JUEnkVblwJdu/GIsno2aefA1knR7EQ15xOxlcm3IFgTVgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1786162063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=daUV1+wGO/CYeDnloHPgUaZDWTkRssQTwTJKBeZ1esY=;
	b=3qYaC7C0BrKwCUunqhxNGaUYVaoZJyDZwvsymsjRe2kt3Q7aliKFyEFACP+RjCCh9O9PcU
	oTk2goaWQJBc03Aw==
To: Kuniyuki Iwashima <kuniyu@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net-next v4 1/1] af_unix: Do not wait for garbage
 collector in sendmsg()
In-Reply-To: <CAAVpQUC5mY9gZH=LmRvdZb1F+QbxGPuNBgSXvHh6pTzZO5QSNQ@mail.gmail.com>
References: <cover.1785824313.git.namcao@linutronix.de>
 <bc759ceba26d6e20fab3bcf7333ee7e6246696b6.1785824313.git.namcao@linutronix.de>
 <20260807180709.6fb7f2b2@kernel.org>
 <CAAVpQUC5mY9gZH=LmRvdZb1F+QbxGPuNBgSXvHh6pTzZO5QSNQ@mail.gmail.com>
Date: Sat, 08 Aug 2026 06:07:42 +0200
Message-ID: <871pc9b6gh.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kuniyuki Iwashima <kuniyu@google.com> writes:

> On Fri, Aug 7, 2026 at 6:07=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>>
>> On Tue,  4 Aug 2026 08:46:16 +0200 Nam Cao wrote:
>> > AF_UNIX sockets' sendmsg() schedules and blocks on the garbage collect=
or if
>> > user has too many inflight unix sockets and there is cyclic reference =
in
>> > the system. This causes real-time issues, as cyclic reference can be
>> > created by any task in the system, and high priority tasks who do need=
 to
>> > send lots of AF_UNIX sockets get blocked by the garbage collector which
>> > runs as workqueue, causing a priority inversion scenario.
>>
>> Hi Kuniyuki! Any thoughts?
>
> flush_work() makes an insane process slow down by itself and
> the sane users (whose peers receive fd in timely manner) can
> likely acquire the gc lock before insane users.

As mentioned in the cover letter, our definition of "sane users" is
quite arbitrary. I acknowledge that it likely cover most users out
there, possibly all of them. But we can never tell for sure.

> The commit message assumes the GC is low priority,

GC runs as workqueue and thus is low priority.

> and it will be easier to trigger OOM and soft lockup without the
> penalty.

Sorry, perhaps I am still confused somewhere, but how can OOM or soft
lockup be triggered?

At best (or worst?), a task can make the GC iterates over RLIMIT_NOFILE
inflight sockets, so there wouldn't be a soft lockup.

And the number of inflight sockets is capped at RLIMIT_NOFILE, so there
wouldn't be an OOM issue either.

> If priority inversion on RT kernel is the only problem here, there will
> be more flush_work() instances triggered from userspace,

Yes, you are correct and this happens often. The solution usually is
avoiding workqueue. Some times we replace the workqueue with a dedicated
kthread, other times we drop the workqueue and execute the work
synchronously. Otherwise we accept that such API is not real-time-safe
and should not be used by real-time application (we have on-going work
in run-time verification monitors that tell user if they are using an
unsafe API).

> and the real problem is that flush_work() does not implement priority
> inheritance like mutex.

This idea has been brought up in the past. Unfortunately it is no easy
feat.

Nam
