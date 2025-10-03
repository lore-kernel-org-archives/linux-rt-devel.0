Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1CF1DD0D4
	for <linux-rt-devel@lists.linux.dev>; Fri,  3 Oct 2025 14:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759500029; cv=none; b=Put2Tu3uenCWaXipyGqoBHfgHduN6imnn2pUCMpGq1n6w/19IAXLCl4qzc9oCgQo5N2/cNSorkXlxbrbAVLalUkGqpH2qhuoUvzQB0V/ZfqI+BnI5DpIEesKqozJSeraxKz9xQA/GebsdneCNwljMxGL/AzE5XVK8tnJdC5ZJ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759500029; c=relaxed/simple;
	bh=LE11OXTwtyH7n2SYHTG2RJk02Tg+uqHJe5QPkn3biIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VS8Hp2cR8T+E2fLoVMO4/am2f7faa97h98SfIVxzJgLHZIaGhEg0PHDrBMJJL3I/EtUMgQ1J871Wn539awUhiBxdRRslGQmnpowoTA5OF4UkORi1+2DFofPySwePJwo10xY8JSnF1BuII/D877DOqZVVEP/85YSLammao1QirIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=foGWtGvr; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="foGWtGvr"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3f42b54d1b9so2024202f8f.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 03 Oct 2025 07:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759500025; x=1760104825; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U1I+/2p2JdPvoE9EVgO8OhJv/XxdkIcGTKg91hG0OSE=;
        b=foGWtGvr5pZ+jMQKNQ4CMLBb+SF5P7kNy3fC073qeqG6qmm/SB3DLvKiG4LnNKHwcb
         1M81UNsi0tEkJcdJf6ygnnfAUQ+EFHkxMnTiJSiPW8YEHwqdoMzbSxPLGS0sjryjY9Ht
         AzNO7r5mXncW1qruA7Tly974p45HBPcHzeMcUdrirgl9+HnsSeFmox6JfvPa0+UEQj9+
         MX/oCaoY285d0ZyYZAm8nY3iqJOETeBgspgp0TWUMXBmoQOOuyhnCTilYhfDqEKjBWo4
         EwJA1o8PuCA8d2TA8SNtFFHj358E3LFFfPxKIan3fzDdkcRaQBuQy8H4gV1aF8W64puw
         TDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759500025; x=1760104825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1I+/2p2JdPvoE9EVgO8OhJv/XxdkIcGTKg91hG0OSE=;
        b=WzhgM/ET1YmDTvsDJ8XF4LQtKQutRnE2oc02moCRFwbDGcipt4fIQImWvKHpWp09D3
         Up7K0vLKij5Y76NKzAdFOTqBsnflsWi5wKzWZavKvstI7W+HHB5YeU3FEEEpRAVGCkrb
         nW2M10v0AGQSfJXje+MgH6RM7TmBTk6QT7LsQH3exHqx+f3QnUloMLnvqRlqwziE4Vk1
         3S8nFvO6IsZPfbVUeDLwjg2xREi+0V6YM6R4lOVA8RzDQBDmoI5GBgFSD057IXp4XW/j
         IWPl/mEANl2X/RJQsL+4ItAdst+jPbEpVSA3mXM6LKRbEtOiVGoGmx8GcUq3HDs1Dhy8
         OhGw==
X-Forwarded-Encrypted: i=1; AJvYcCW3JOwv4G7AHCeh8L2xm4driX4YB+tjs6JzRPQ3ps5yb6ooys7zk4nSMFbhApzklxMmKRVMycBxVrb+yDsgSA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwEnMtvxJv3XHoc3kvxEkJ9hsPKpKPwIkKFpeH0RPdVeWJIe6T7
	sfLcvB4QYcYz3HMJeWmsdqJCe1LVfShupDGiDfqwAJNxaEvjbaqsizei0Sw6qiWyK+4=
X-Gm-Gg: ASbGnctnm9nRDgVwwOlVPcTvss7wVy7b3jEkW8z5ckja6igXgfxs6JBSGamNWQrvtcd
	pZMQbjJNVN/8saC9kP9jsF6Uy+t+zCOGpSQ52xRQUiqJILDCB8uVQaUKv1opCF6/2SYg8L/nrVu
	SnpgY2sHCH6cXRT4HWMaOjhpa3eto2b4VsnodkVRw3MqEAUF/GAmhMCyWmoSt+0F4IYqfLIGhNM
	hX4Ak7hQDyRC7pR9/5Ptn5Hb362gr2PtH88t2f6ADMNCrK72rb3d2RDqENBWt7mANiUdEj47rvL
	mpQaPyOmU9nfarsoncOalLjTthcbs2mWwQNBbiGk6Hl4JssOcPFnuTKiSOgr1Qg2n/NyEkGrEXd
	sA/BNdQX+pk9HchrXf3QohuN9vwuKG3CHC9pELNwpXoIhK1zBIgGYma4YJ6oghrDxoTk=
X-Google-Smtp-Source: AGHT+IGxLyC2md5Jx51m9HM2p3j5fCUCQApXbhQWufGaXIfDffbKLaJKFwko+zfFqgwUdARWXwlQ8Q==
X-Received: by 2002:a05:6000:25c6:b0:3f5:d7c0:8e20 with SMTP id ffacd0b85a97d-425671c53f0mr2152207f8f.59.1759500025479;
        Fri, 03 Oct 2025 07:00:25 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e723431f5sm31917445e9.2.2025.10.03.07.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 07:00:24 -0700 (PDT)
Date: Fri, 3 Oct 2025 16:00:22 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Nirbhay Sharma <nirbhay.lkd@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Tiffany Yang <ynaffit@google.com>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	syzbot+27a2519eb4dad86d0156@syzkaller.appspotmail.com, skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	linux-kernel-mentees@lists.linuxfoundation.org, Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH] cgroup: Fix seqcount lockdep assertion in cgroup freezer
Message-ID: <nbtofen2pwqmp7r5odbyc4en6vv54rpznyaanxlb6tbx5yyg25@jx2re5hdmt5e>
References: <20251003114555.413804-1-nirbhay.lkd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="twwjz6pyzgqr4kbn"
Content-Disposition: inline
In-Reply-To: <20251003114555.413804-1-nirbhay.lkd@gmail.com>


--twwjz6pyzgqr4kbn
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] cgroup: Fix seqcount lockdep assertion in cgroup freezer
MIME-Version: 1.0

On Fri, Oct 03, 2025 at 05:15:55PM +0530, Nirbhay Sharma <nirbhay.lkd@gmail=
=2Ecom> wrote:
> The commit afa3701c0e45 ("cgroup: cgroup.stat.local time accounting")
> introduced a seqcount to track freeze timing but initialized it as a
> plain seqcount_t using seqcount_init().
>=20
> However, the write-side critical section in cgroup_do_freeze() holds
> the css_set_lock spinlock while calling write_seqcount_begin(). On
> PREEMPT_RT kernels, spinlocks do not disable preemption, causing the
> lockdep assertion for a plain seqcount_t, which checks for preemption
> being disabled, to fail.
>=20
> This triggers the following warning:
>   WARNING: CPU: 0 PID: 9692 at include/linux/seqlock.h:221
>=20
> Fix this by changing the type to seqcount_spinlock_t and initializing
> it with seqcount_spinlock_init() to associate css_set_lock with the
> seqcount. This allows lockdep to correctly validate that the spinlock
> is held during write operations, resolving the assertion failure on all
> kernel configurations.
>=20
> Reported-by: syzbot+27a2519eb4dad86d0156@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D27a2519eb4dad86d0156
> Fixes: afa3701c0e45 ("cgroup: cgroup.stat.local time accounting")
> Signed-off-by: Nirbhay Sharma <nirbhay.lkd@gmail.com>

Link: https://lore.kernel.org/r/20251002165510.KtY3IT--@linutronix.de/

Yes, this is what was discussed yesterday. Thanks.

Acked-by: Michal Koutn=FD <mkoutny@suse.com>

--twwjz6pyzgqr4kbn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaN/W9BsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AgskQD/VZYTSgJV8TksM06o+G+A
UVtyHkxTmx7U6OUOjRKT7lEA/i5BQk7/GJc2WflFnRYc7WUQqlTYbotjwBZ2vWgK
dSMB
=4Bm5
-----END PGP SIGNATURE-----

--twwjz6pyzgqr4kbn--
