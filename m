Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4C22BD03
	for <linux-rt-devel@lists.linux.dev>; Thu,  2 Oct 2025 17:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759425460; cv=none; b=t8alIHPLrI4PeDkxpOHvhJdc1xxmKKDAdH6SK4Yca0EA6oklgFWBvh6lA0rJoK76me4Fw6L2lbiwWPKb7eZy21IRx8ScQBMF3uJlBv9Ebzv8y0x5poaxJHGZjN0qk6eR9XtKklVco0OtInYXZoEVwEcHaOaluObkZDlcD2gD+mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759425460; c=relaxed/simple;
	bh=jvFZrFn5e7n6PhwcbhBV7Smq4LwxWDGpJHOfXtGaf3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScP9heqgructeWu5OvhfZAerRicXkO16utqVol+opBiron91a2BqhKG6AOZuDPcFSbzokleuxNS7q9M/gWwNyScYdCdJgpjGw0KvYaoXOvO9ldZfsWDLdhhrp4RxptczNa7R1psw5NH8jhS5+yl22vHchUH39MGlVv9EsfGn8pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=f4zs4LDa; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="f4zs4LDa"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e48d6b95fso11360095e9.3
        for <linux-rt-devel@lists.linux.dev>; Thu, 02 Oct 2025 10:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759425457; x=1760030257; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nEqi5LiDufQ4XizIhNMHWocMl1nEMNZ4fHJRUgvpBfw=;
        b=f4zs4LDa1QKO/9kbaEWb8pG0idxBIFFlQWTkIkAdAgheWjJLNiq4/sT/hQzOgzZwp2
         Fl4+SsAqh+R5JInu3XlLMFmUkpMBxcJzs5TUKWgPmGCVumfsf/vyqcQ7+xRwoqe6GlUe
         TIc5sel7A02wm27iabMBUkIdF45f7lLCwiKZuro6JAScidy+/MGocGQMJJNx9oOXEWBK
         45iT6SxP9edG2exE5JCBgfvuIafhn/0Zv62UYZNMArAI8Dg6t2mXXEDpCHhHmvi8goAm
         MWGzRNjkgXDQOeDCWzWFoniUKrVMm2DUyMIaW49CKsYYLou21f+yaSBsNp2sq78B8ZsW
         S7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759425457; x=1760030257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nEqi5LiDufQ4XizIhNMHWocMl1nEMNZ4fHJRUgvpBfw=;
        b=eFQflPQG9FOU+rZCIWVrWgBTVF7qui7IyiVQqcRsEEUUHI06hbOnZkFeZBKOt//D46
         e42dpyZ87Skl0DO6MBMY1jRpBO5QbW09oTQn+AZC+2UMocgfqGMKLc8cG43YID5fyL32
         EiiO2WautZ3x0CxFUeKh/r0Hxd7gb5OeJatAYXtrJ0Dp3SYNq9rErT2aWmKPTguy3CCr
         IBGKMpS3hvV9Mp8xuVZV23PVwRBVl4LJ+T6PgV2he3MPdsHgpGVstiCeAMKIJ4Ck711x
         8T/fDpuNFaCPcrYdAg7/VfWJ9X725yMaB9kegUHYIbxpdqRb6KXfOmhZvyECm1wTAMBm
         iShA==
X-Forwarded-Encrypted: i=1; AJvYcCXrpCTLmqJmThwRqqOI/AL3Zu9LlVs8GclNYX9UmtTnlt6YvYUwGFazOI1ejVhuSMxxZF6nEGkesYuZ+XLbtA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxIlXgFLY3O0YHI02CQy4EtLMb3QodQ5fBWeyXNwlo0/+j/zAuu
	SteyPKXEneZjAeNINAo4W6Ch7iy/w5J7cLngvOnI6TkLBXy1scJIOuFXGUQgTslM4FU=
X-Gm-Gg: ASbGncsbpq/zXwMn8DlSvEXskUe9GAfrseOGL3dvdhkdJ/wqyuG1H1vzmvlqPOjpUpX
	yrgjYNzQqDmJbay01wjrmN/+pMhuPKCzzOIvut59kjA5PqE0tJ9tW/0vgXYyigwLydPIcyJ0eb3
	AsyUR9P9nK8ArLwJxZFH6eEDlhGRtwdSz2H5oukjoB02vwpiZeXDKXy2e33cOyP4uFNCcjcxxrh
	En/f3Zd6GPlfv8UJQzdCW6WVjdZvr4snY47t+MRVUjOtjDsqYTyR+ORzSDfDXciMhuf4KCM5ofY
	TdcoE8i1HDUEvKR8SyVvmFdL690PxE2TFhTu7/X2kegzuIsby5/DwNwWsG32twzCQpwHPMM9TiS
	yvl0VUKQ7F8sOoFfbwLybZ3ffDur9sBkroIH2lYpRNYra/fza+fBlYnfieEjQN0SqWdY=
X-Google-Smtp-Source: AGHT+IFVIFNSt0EkPwbXYMRmsUgvjGJ90zoP3cCqPOxCOQ7syB49MVnAQ0tTwadDuJJr+K2gGskVDg==
X-Received: by 2002:a05:600c:1384:b0:46e:19f8:88d8 with SMTP id 5b1f17b1804b1-46e7115c5cfmr202265e9.34.1759425457072;
        Thu, 02 Oct 2025 10:17:37 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e61a16e13sm92087335e9.15.2025.10.02.10.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 10:17:36 -0700 (PDT)
Date: Thu, 2 Oct 2025 19:17:34 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Tiffany Yang <ynaffit@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, cgroups@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	syzbot+27a2519eb4dad86d0156@syzkaller.appspotmail.com
Subject: Re: [PATCH] cgroup: Disable preemption for cgrp->freezer.freeze_seq
 when CONFIG_PREEMPT_RT=y.
Message-ID: <3ecuzzwx73xti3hhm6aoolpodpvntdw3b56cq6au63luodhbmo@bwgm4v5rxobo>
References: <20251002052215.1433055-1-kuniyu@google.com>
 <5k5g5hlc4pz4cafreojc5qtmp364ev3zxkmahwk4yx7c25fm67@gdxsaj5mwy2j>
 <CAAVpQUCQaGbV1fUnHWCTqrFmXntpKfg7Gduf+Ezi2e-QMFUTRQ@mail.gmail.com>
 <20251002165510.KtY3IT--@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hrmmohwe7ivs4hnr"
Content-Disposition: inline
In-Reply-To: <20251002165510.KtY3IT--@linutronix.de>


--hrmmohwe7ivs4hnr
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] cgroup: Disable preemption for cgrp->freezer.freeze_seq
 when CONFIG_PREEMPT_RT=y.
MIME-Version: 1.0

On Thu, Oct 02, 2025 at 06:55:10PM +0200, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> Nope. period_seqcount is a seqcount_spinlock_t. So is pidmap_lock_seq.

Oops, I didn't check that write_seqcount_{being,end} are macros that may
accept different types and mistakenly assumed seqcount_t too.

>  	/* Freeze time data consistency protection */
> -	seqcount_t freeze_seq;
> +	seqcount_spinlock_t freeze_seq;
...
> While former works, too this is way nicer. Not sure if it compiles but
> it should.

Thanks! (It's therefore also better aligned with the other occurences.)

Michal

--hrmmohwe7ivs4hnr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaN6zrBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+Ai/IAEAtKwPeHVDsi3iKGHvJSrT
1RUKf3glL+87w6uXTAAE4v0A/2tUcS+rEgj2/ukWAn1K2FmmP4bHQUMytwfBuB+8
SFUM
=AgIL
-----END PGP SIGNATURE-----

--hrmmohwe7ivs4hnr--
