Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A839A328B4D
	for <linux-rt-devel@lists.linux.dev>; Tue, 10 Feb 2026 12:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770726335; cv=pass; b=NSNfR+eZH5fMs4U7tLav4mb9V/8mCpM856bqzJNl3gIfyNl+R63wr/KHCY7YHC+x0FwZbM8kBYNeVXsMCUudYSatpQIjfjYj4l3xU15UZwUqxRYm2Cp7NquagBagrFCKiPmyuR12tYT+bMPDuNaJjUltglSt/IyUSpZqQEj1uj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770726335; c=relaxed/simple;
	bh=jb3QxqqEthIDSleH58vWDEdSIpokZJFfaIlRJ/kKfQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QJWnPG8/DOrywolwEeM6fO74z7je9meSTq6d/6YQauHNfFkYUpScQk8DAQaXn9JWGKyywyHMbXnUobnZzBUsaPJKejUgMLw8kA7sYZ/o47rEVf1FLIdDX9ZhOh0qKB9iR/8e9pa2kZWy9Ri+Jtivxyh7NXx6HGlihYsq48Ho6oY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dq6RKAx7; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dq6RKAx7"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-126ea4e9694so5033639c88.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 10 Feb 2026 04:25:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770726334; cv=none;
        d=google.com; s=arc-20240605;
        b=YFeNaVvE+7T6l45w+myKqOno6bOgQ3rkkp1au6gYrQdfzrXhsLtL+2Lrue1t+EEQ+F
         DPTJ1IoHYVY4CkTCQK/1+V4528c+z3Mg67dHflHdAd3O+dW+5D9SRpim16kc+xjXd1fw
         whVE8IB1QFgw0tt5XjEsd7Lqs74V9i+asYkMmQOh7i+fm47L4nPSANo9El244zDhRqp7
         61TBivcuWNsim13YaDT4QtEGMnjPOLUYbMk/RbivySmecOuwVyKrjRHcUa2zIp1tMG1v
         EgLirBJu/GYmNl5b21MBwZxDAT23IEv9zafoGqe/jl4iaLtdv8KXlb8k7h0madAJ1HK1
         ZorA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lviK+3J/qBKUnpjJJ7UIbk90vVi/aBRhlSNNHXg7jFs=;
        fh=dTXJQTcV9rDPw7xvQCK+NEfwXi/AWSNXxOU8HwzZtTU=;
        b=LKJhjH5xAwkQxOZMi9KuzlxrLDx9iAsycKDkU3EX3mjXgiLoc1wrbVL7ca4F7A/yfL
         2XprNVIjkYxQ6nwtS5YPjPNMxJ/sSyBtDKEpX92QwZa68JIWDoixRRXk6baQXIdxlMQT
         w4dLHvcGQNDbjfqaUA5wP6QpC7Bz3kkBpC4YSDXpBAKH2B9lJF2kmQILIjXENFk/rirQ
         vdIw+PozlifVrtxgMyIuYA3l0r1nSc09pr1zhFOc+r7nDGLGMGHvHQ1V2z2NcAlWRAU0
         u3pSrIMyGaBDXOSAkLIKKJSmhyfAuq/ZXraL4IGCSMQSd21pLpTqdjAx4bNklWeYLUTu
         axww==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770726334; x=1771331134; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lviK+3J/qBKUnpjJJ7UIbk90vVi/aBRhlSNNHXg7jFs=;
        b=Dq6RKAx7IoY09WgOK1GJ9m1ACXb7M7m/exrYsdOmoqb6vQPXR3nIaHJKq7zioCzrvA
         LBaZc0baG8NCBYR8HLMOSd2t3KsParokyrTr/jHly4Sjw0mJ/r3qugW3oRdpmc5XX99/
         4juK5ZR5CLA8cijrgta53xUveqxQE19fO9jrGzYy/VjcfwmYYFapPxpN3xy7i+752mX6
         yB77rms6GgmjJf3zfpu3xHnY+nmPil3WOZqgiT0bnCVl9HKM2L/j2FiLfkv/1GEQAXMK
         TdLbcY6JhCC7Nc+/LnTrU9Gajl/6YXb2E/urVmu9ZKnTxK1/h+JZVS8BfaGIIYav0BJX
         kRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770726334; x=1771331134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lviK+3J/qBKUnpjJJ7UIbk90vVi/aBRhlSNNHXg7jFs=;
        b=Wm1uz0GC84VHknhRZWpui2+JXxFINm3451JFcAYBAFGrJTVsqgrzmWGq6LbgyAbcF5
         2PlDl0l62ntfdrYepb74cbWczQujiilyrlemgygJaIeIY9QGaqwEljrGh/V3Zp2r1p0D
         PIYcQjJ8Lv7kQhb9Q/0KR+UkQUkW2po5VF2ryx258v8S3qcOcULYmppBiFxigy7xT3ca
         oUKtvXoDGq98EQj7qc4Yw/HQ0XXrpdeFxctYFotHVpBbt+t7w8myJI/ABqy7BqXecTnS
         tIrIgBjJ+hyU97xTtCZ3wffz52VLM/8lqiuqTexOL4SJH/c6poT5eLUvFuleXwRybORL
         38eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWa6psEt1zpcd8GR6Rr+n+qaWbphbW8aTsmTXoAZq+v2UQtaCdE94gP/pu4alQRiRK3GAaUpKEvuInPxISjOw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz56WQQj4xADluL78mvzD5UcotUCLAKcpgZ6jg7lnJTWdwAEqxG
	65opaIQqsUZ2aSHiveU5EddSJzRKg2T8KbG/91iYQlT+AHC141ZIdLyfrUZJmf6hijpgEVad4h3
	d756AUTu3a9SRvlq11l7UU3KP+s3+RSw=
X-Gm-Gg: AZuq6aJnpPOGHlRsMgV9PVe9mozIMMlh0pWKsUNYTXlDUirfviSy6stjLMpbTx4xY7v
	CbZlJ8dzTP/d7fl2HFHOYZim/xJ4P90TluxzwiekB67jlCtFyT2mRbGG8cALU0HZKhblA4w06dg
	ihdx5/Yqu+PX8vPatT3NTTQN5588TOQ8EJ4WLIl+FKC2b82YfujosJoo9lhI65faf2+EvESCDLX
	GYOMfARWKk9suX7bmhuFWYHxkITtoDnAdpHYbi3x1fMFhM7s3RCPxV0i3vZ1mtw25oF7Zj9yXhT
	9zo0LEw=
X-Received: by 2002:a05:7022:224:b0:119:e56b:958c with SMTP id
 a92af1059eb24-1272431f95amr858651c88.17.1770726333597; Tue, 10 Feb 2026
 04:25:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAOi1vP9fvjfu-WsfL4RUw8mAK01rcbU94VvVxfacnskW6JRMNA@mail.gmail.com>
 <20260210071929.15602-1-ionut.nechita@windriver.com>
In-Reply-To: <20260210071929.15602-1-ionut.nechita@windriver.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Tue, 10 Feb 2026 13:25:22 +0100
X-Gm-Features: AZwV_Qgh3WVc2qo4eqJSbtl9thpMXsvcFZWidI0_bdYXe-7IhGbPjDprxBTST1E
Message-ID: <CAOi1vP8WVkwy85VechMGzbROEB6AFzey3Uquz-sYRrJ2uLm6wQ@mail.gmail.com>
Subject: Re: [PATCH] libceph: handle EADDRNOTAVAIL more gracefully
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Cc: amarkuze@redhat.com, bigeasy@linutronix.de, ceph-devel@vger.kernel.org, 
	clrkwllms@kernel.org, ionut_n2001@yahoo.com, jkosina@suse.com, 
	jlayton@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, rostedt@goodmis.org, sage@newdream.net, 
	slava@dubeyko.com, superm1@kernel.org, xiubli@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2026 at 8:19=E2=80=AFAM Ionut Nechita (Wind River)
<ionut.nechita@windriver.com> wrote:
>
> Hi Ilya,
>
> Thank you for the thorough review and the good questions. You're right
> to challenge the "1-2 seconds" claim -- looking at the dmesg data more
> carefully, that was misleading in the commit message.
>
> > I'm missing how an error that is typically transient and goes away in
> > 1-2s can cause a delay of 15+ seconds against a 250ms, 500ms, 1s, 2s,
> > 4s, 8s, 15s backoff loop.
>
> You're absolutely right that if the address became valid in 1-2s, the
> third or fourth attempt would succeed. The problem is that in our
> environment, EADDRNOTAVAIL does NOT resolve in 1-2 seconds. That was
> an incorrect generalization from simple DAD scenarios.
>
> From the production dmesg (6.12.0-1-rt-amd64, StarlingX on Dell
> PowerEdge R720, IPv6-only Ceph cluster), the EADDRNOTAVAIL condition
> persists for much longer:
>
>   13:20:52 - mon0 session lost, hunting begins, first error -99
>   13:57:03 - mon0 session finally re-established
>
> That's approximately 36 minutes of continuous EADDRNOTAVAIL on all
> source addresses. This happens during a StarlingX rolling upgrade,
> where the platform reconfigures the network stack extensively (interface
> teardown/rebuild, address reassignment, routing changes).

Hi Ionut,

For how long of those 36 minutes EADDRNOTAVAIL was actually being
returned from kernel_connect()?  I'm trying to separate the time for
which the external condition persisted from the time that it took the
client to reestablish the session after the resolution.  The
"approximately 36 minutes of continuous EADDRNOTAVAIL on all source
addresses" makes it sound like kernel_connect() was returning
EADDRNOTAVAIL all that time.  If so, it would mean that the client
managed to reestablish the monitor session in 13:57:03 - 13:20:52
=3D 0:36:11 (i.e. just some double-digit seconds on top of the error
disappearing), which would seem acceptable.

>
> The reason the delays compound beyond the simple backoff sequence is
> that there are two independent backoff mechanisms stacking:
>
> 1) Connection-level backoff (con_fault in messenger.c):
>    250ms -> 500ms -> 1s -> 2s -> 4s -> 8s -> 15s (MAX_DELAY_INTERVAL)
>
> 2) Monitor hunt-level backoff (mon_client.c delayed_work):
>    3s * hunt_mult, where hunt_mult doubles each cycle up to 10x max,
>    so the hunt interval grows: 3s -> 6s -> 12s -> 24s -> 30s (capped)
>
> At steady state, each monitor gets ~30 seconds of attempts before
> the hunt timer switches to the next one. Within those 30 seconds,
> the connection goes through the full exponential backoff (several
> attempts up to the 15s max delay). The round-trip through both
> monitors takes ~60 seconds at max backoff.

What is meant by both monitors?  IIRC the client only tries to connect
to a single monitor at a time.  How many monitors does this cluster have
configured?

>
> > How many attempts do you see per session and in total for the event
> > before and after this patch?
>
> Before the patch (from the dmesg):
> - Total error-99 messages: ~470 connect attempts over 36 minutes
> - Per monitor session (one hunt cycle at steady state): ~8 attempts
>   (immediate x3, +1s, +2s, +3s, +5s, +8s before hunt switches)
> - The sync task was blocked for 983+ seconds (over 16 minutes),
>   triggering repeated hung task warnings:
>     12:52:11 - "task sync blocked for more than 122 seconds"
>     13:31:05 - "task sync blocked for more than 122 seconds" (new sync)
>     13:33:08 - 245 seconds
>     13:35:11 - 368 seconds
>     ...continued up to 983+ seconds at 13:45:26
>
> After the patch:
> - The ADDRNOTAVAIL_DELAY (HZ/10 =3D 100ms) replaces the exponential
>   backoff for EADDRNOTAVAIL failures specifically, so retries happen
>   at a fixed 100ms interval instead of growing to 15s
> - In testing with the same rolling upgrade scenario, the total
>   reconnection time dropped from 36 minutes to under 3 seconds once
>   the address became available, because the client was retrying every
>   100ms rather than waiting 15s between attempts at the connection
>   level

This is where I'm getting lost again.  It's stated above that in this
environment EADDRNOTAVAIL doesn't resolve in 1-2 seconds.  If it takes
minutes for the underlying error to disappear in this scenario, how
could the patch result in total reconnection time dropping to under
3 seconds?

> - Total attempts per event: similar count, but compressed into a
>   much shorter window with faster recovery once the address is valid
>
> I should correct the commit message -- the "1-2 seconds" claim was
> wrong. The accurate description is that the duration of EADDRNOTAVAIL
> varies widely depending on the environment: it can be brief (simple
> DAD) or very long (complex network reconfiguration during rolling
> upgrades). The patch helps in both cases by keeping the retry interval
> short so that recovery happens as soon as the address becomes
> available, rather than potentially waiting up to 15 seconds for the
> next connection attempt.

Is this setup experiencing the brief or the very long case?  Or is it
both, heavily intermixed?  Speaking generally, if the address doesn't
become available for tens of minutes, waiting for up to 30 seconds on
top of that isn't a problem IMO.

>
> I will also note that the connection-level backoff delay does NOT
> reset when the monitor client switches monitors via reopen_session(),
> because ceph_con_open() sets con->delay =3D 0 but the new connection
> immediately hits EADDRNOTAVAIL and con_fault() sets it right back
> into exponential backoff.

... but when the new connection goes back into backoff, it starts at
250ms, right?  I'd call that a reset since the new connection doesn't
inherit e.g. 15s delay from the old connection.  Are you observing
something different there?

Thanks,

                Ilya
