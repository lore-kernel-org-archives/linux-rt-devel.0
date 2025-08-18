Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E7B34573C
	for <linux-rt-devel@lists.linux.dev>; Mon, 18 Aug 2025 16:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755536338; cv=none; b=M8nzLddq4rVeb6LWldec+IAB/ybfC830y6uI+Z67kVRP7h5/YD8YMFO+XC8BnXTHR4QiLnzMn+HDGOqcPadXePtFRhRQnkT5LQE7XhdIWh5NoEDtfvXUT1e5jkMfJqrvr7JkJw7tkIW3YWCldUSnR53u/5+hUAyNQySg5js3lcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755536338; c=relaxed/simple;
	bh=p3B2R6aWiPs6A7CSWvjKLk6T3ok9VaClfEOPI/l8ICQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LvyQeq1xxQ9hR6B/FSYCWB0WzU+aoRpd7BE2z8NWS03dVjbOuUZ3QcG2PgGwjGsSlZCbPCJWoxt/+qLBUmGvHp6p3aH6OXvLdtau+C/USg9fzo3c0X5Rk5s8bC0i7gmQwEOKkwTcmKjTFLh8oPZAwWe5dCkrFOokAVePblLC3vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yqqyvolh; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yqqyvolh"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b109bd8b09so56942231cf.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 18 Aug 2025 09:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755536335; x=1756141135; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDHDb/C2H84Q+lQJukTeAn8mnYueu1KVL2ulPYI19q8=;
        b=yqqyvolh7amDwqE9jDA0vUXn2SKSkllCi986kPu/TYZTn3KfyQCPMulDVxiAuoObQ8
         XpZqKhUelKujCh5jteVFdpY/zXLvi7DN9OJTFLKKICZBNiX31Tgo47FOx3Ln/nIqFOHF
         5jdyk06N3I7pxGRPC4Cbww3PvbjTcLsnN5ZEPAeXqptmoOwIjSuaqOV31G8ROlSJg0H2
         8aEpzLkmch8PwZznwGNBwbGYgIoUMtHjWEDkFn7y0mVoyAHsULN8I9s4DutN3eoH+wSJ
         Fke95pf1yBvS8IdwDz32vDMrVSaqa6QhLG6+Ay31+HoiP077FEPi+x8rxt3r/xKDHEJr
         awyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755536335; x=1756141135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oDHDb/C2H84Q+lQJukTeAn8mnYueu1KVL2ulPYI19q8=;
        b=Sv4vZuGcLSKmIfwCI7pMIKfSJ7HVT4ypUu257JZza7sNFOCeSt1zucRdAmJ2ToOrB1
         nTDO+D7f/yUv1OaOeynnHjwA6vbvg5o8meF7CUQ6d62r7CXkukKR6i8ixECZKLc2/XOE
         qBKTs181vpNlv1R/ZiaYUCIZImd9YN7qazLQJReeZ2OzGqAk02Nlm5bZIFHAFDaaiWvJ
         8jAZ1FdnZZ1nhI19OieXaQfOHipbf2IGsfvKzmSRV6yorVCT+C/NcJ+Fi5xABZCDmRls
         960DZ4kzNP2ULAiZbHXEkm4KYOGrx9xRVOZOmpFp4ePvt9tgP4Bom2QszyaIDWm1Kr4i
         3RSw==
X-Forwarded-Encrypted: i=1; AJvYcCVJlDrodEjd7fg0jDgo7HihjBHOje1pBFVY8hdMx8FZ7i13LUF0mqk2IGxGugbFn59WGP3UJ0+8cuOCkVmXgQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwsbmBacuZuQOHOS0OJffEGS/uD2uNaCaIISr2yuX/FOGcPz9L3
	IbcXt7xsyp3boGUZHykw5arU6ErftIqORGKVqXMT321IgKkuf9U9J1mcR+UCE+frH/pfRM5Kij/
	N09CyFYWV8WLQeffHyywThcjnBa/pC2/+cmzF5UH+
X-Gm-Gg: ASbGncuFkteIfjnk2iFCCH05djq0MRHsymE6qenN1DfXlxUS74yg58/k/Q4v5ZvC/V7
	Cdk9yYf2BKCgNXiuqTtZ3hRh0IMn2NlQVMj06n/3g00TqDxA+xNAymrHfqC0Rbkkpo4vQmNQVIu
	Cy1yvqFKiXXGCR6lUxgdY0m/zzn2L+Zc03l3LLdHjAj0LO7h4oIPZ9mP+oN5/kmjnOHzDx8XY41
	Mr0nXkinKeH00hihWE=
X-Google-Smtp-Source: AGHT+IGmJ4mnfL5FqQtImDyqbmLr8KCmFM75FY8ubsT1KIUDOiNywm2giVJ2jvVz1iup0LaOvKLIDCWtQ0/OJN4WkYU=
X-Received: by 2002:ac8:5813:0:b0:4b1:d6e:f03a with SMTP id
 d75a77b69052e-4b11e2cd43fmr148785111cf.63.1755536334704; Mon, 18 Aug 2025
 09:58:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <3edfd3ac-8127-41c2-afc5-3967b8b45410@kzalloc.com>
In-Reply-To: <3edfd3ac-8127-41c2-afc5-3967b8b45410@kzalloc.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 18 Aug 2025 09:58:42 -0700
X-Gm-Features: Ac12FXwchqtMPDdyef8PmWwAFtLMe2-HRyv7KFfiL8tS-4s9vEtEjMcDaXkbhpg
Message-ID: <CANn89iKCE2ofvPTAcUbLCKE46_y3gMs_tdh1D5214WnAs8Fjmg@mail.gmail.com>
Subject: Re: [RFC] net: inet: Potential sleep in atomic context in
 inet_twsk_hashdance_schedule on PREEMPT_RT
To: Yunseong Kim <ysk@kzalloc.com>
Cc: "David S. Miller" <davem@davemloft.net>, Florian Westphal <fw@strlen.de>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-rt-devel@lists.linux.dev, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 9:46=E2=80=AFAM Yunseong Kim <ysk@kzalloc.com> wrot=
e:
>
> Hi everyone,
>
> I'm looking at the inet_twsk_hashdance_schedule() function in
> net/ipv4/inet_timewait_sock.c and noticed a pattern that could be
> problematic for PREEMPT_RT kernels.
>
> The code in question is:
>
>  void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
>                                    struct sock *sk,
>                                    struct inet_hashinfo *hashinfo,
>                                    int timeo)
>  {
>      ...
>      local_bh_disable();
>      spin_lock(&bhead->lock);

Note this pattern is quite common, you should look at other instances
like inet_put_port(),
inet_csk_listen_stop(), __inet_hash(), __tcp_close(), tcp_abort(),

>      spin_lock(&bhead2->lock);
>      ...
>  }
>
> The sequence local_bh_disable() followed by spin_lock(), In a PREEMPT_RT
> enabled kernel, spin_lock() is replaced by a mutex that an sleep.
> However, local_bh_disable() creates an atomic context by incrementing
> preempt_count, where sleeping is forbidden.
>
> If the spinlock is contended, this code would attempt to sleep inside an
> atomic context, leading to a "BUG: sleeping function called from invalid
> context" kernel panic.
>
> While this pattern is correct for non-RT kernels (and is essentially what
> spin_lock_bh() expands to), it causes critical issues in an RT environmen=
t.
>
> A possible fix would be to replace this sequence with calls to
> spin_lock_bh(). Given that two separate locks are acquired, the most dire=
ct
> change would look like this:
>
>  // local_bh_disable();  <- removed
>  spin_lock_bh(&bhead->lock);
>  // The second lock is already protected from BH by the first one
>  spin_lock(&bhead2->lock);
>
> Or, to be more explicit and safe if the logic ever changes:
>
>  spin_lock_bh(&bhead->lock);
>  spin_lock_bh(&bhead2->lock);
>
> However, since spin_lock_bh() on the first lock already disables bottom
> halves, the second lock only needs to be a plain spin_lock().
>
> I would like to ask for your thoughts on this. Is my understanding correc=
t,
> and would a patch to change this locking pattern be welcome?
>
> It's possible the PREEMPT_RT implications were not a primary concern at
> the time.
>
> Thanks for your time and guidance.
>
> Best regards,
> Yunseong Kim
