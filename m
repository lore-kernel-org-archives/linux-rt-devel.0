Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16DE397920
	for <linux-rt-devel@lists.linux.dev>; Sun,  4 Oct 2026 14:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791125021; cv=pass; b=DOFU9rtr44iJp5nONgScrJZX19KKtNX7qYPCPV6hvGp2lqjo5RdOzpNDH//uNlSHATOQ6/SN/V3RWP9I6drGvslt5Ls8vkk7iyuxPIdumsWpY+eYx4qTa7xaJzwhcPeLo5SxKd2gm1MM4b6ih+lhPIMyryQXmubAzirxGipL1as=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791125021; c=relaxed/simple;
	bh=/0GCEHSBrx/oLdC8mUVBcqc/kgOvtpuBhykRXWdVcfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nBVIKYhxTSUV8hdOOF7IuU28J8WixZR0UDmaBNgAACbhqb7ZAWlAbeoC9s+CtS2JB1mz8xak6RiXiwHi/D+oRSXfSmFsY4xUSH2QpDK1/hMrbE0ZU5c331nAo/yCswGagLQjkXK+lTPRw71PtItcOVfrQazagw+9Xm7Bifmw72s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFUmTCir; arc=pass smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFUmTCir"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466cc9b2f02so76098fac.1
        for <linux-rt-devel@lists.linux.dev>; Sun, 04 Oct 2026 07:43:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791125018; cv=none;
        d=google.com; s=arc-20260327;
        b=FIQWm1aaSJT8VIzwsyGQS7kuJi+By/wvSTGHcJh9n8rGIPq7YQc94M5TFxw6ojVuU1
         POJeJz9W/AQ7lMBjs7yjiqBTfan1J9ZJdWHXYrngCz4tBX5r97QuB9xrnuTmxpvSZOWK
         zDsZPl5wGDmlNmpBofsF/f2BUvVULQFm83xqKLGMGRvoQ+hn818Rnzq4ESlpZ88Tl+9z
         KOEAgnMEse9FsPy/B/LYLyvL3TobXiEngcMlGM0mYXJ+PWc4WJ3gEwZ4mGwNighuuKiF
         vzOOZGbXoKVFR1iF0UprqY/IDReVeiz07xIw1H8U/MWknrcPTiFlAsK7rRVxobqHnQlZ
         V94w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vO8DVUB8eovbQ61VNyC+4aG7Y+QXZ4ZRiFqL2N54is4=;
        fh=HWeLN/MlYPyyvjpq61/Uq4BSpmcYOI/3lde31Dw7Z34=;
        b=jfbXHbBgLhFIf8yfl7EqLYpPDKuimhDaVtV6RyCX3tATHef2ZYPgTaTbAKRF9KVDBq
         BO7kfhxSmszA9ErAZckeVpl8o7yeN2cnzeiDcM/7goDOlcELrYA3vkIjugrLcacl6bKA
         qjYWsjoKP2wSiIfUQRpk6PpWzLv0/3qhkUOV4QkP8VoV06CRKffT2qHzw8QkjZgzKMFH
         bgKm/zKB3Jg5A58GXhXm68CuLSBOS3NFEj3T571cHSJAnCeSLK2se19e+R8BIMy4e6Ta
         /r7dDpLahP6uzeQKe0btHNLgvv1rLblQ3q+L7TpbQRywLMQ76gg32b6nwwF/Iuzuf8ww
         CunA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791125018; x=1791729818; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vO8DVUB8eovbQ61VNyC+4aG7Y+QXZ4ZRiFqL2N54is4=;
        b=AFUmTCirX7Pav4eJ1m7ymaSiLo68CFz6Ty8d9Rw/vcdh9YSat0LMz1QIMbhOyA9u+B
         g5FebGRamPp9YC4LAaPcWyh/Y++IRmloU5jz2czd9F3AFnk/AK7SnYbGetdWdlAaPnUL
         US3zxD1Vouu2OEAlq1SpsRCBjylEgP0DiiPdp407nEHSljGWUcU4jICgMrmjGlRc3brW
         OosXqz2umKESdqxdW/m4j8/II0mDniykAbSQW9RvRdpPFexO+PT0wWCHzTK+BSiyxpyy
         CJws7xb2FA+8XSjh9sX5jmcEUFO8VkeiGv8NtzvBYQIwuyvNfUZeyVwgBCEOCP6+tbsL
         +xXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791125018; x=1791729818;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vO8DVUB8eovbQ61VNyC+4aG7Y+QXZ4ZRiFqL2N54is4=;
        b=crIeDpde0XBGyiMluIKwMAnfKB9uPELEAeEp7+RMFSHtCxV0SuTe7t3MWEhP7DaUYP
         9wvuFeA5MwQVo45d2OOj36VCUo9g/ACoxRhPWnXx0g3eVEuXXl/63GgKGogckX1zMSWH
         lHM0SU+oWoDuN9JBwOciEKxU5D1Gf1P7UGrEKfSCr5ERXYf62dbl8d92OQFp6ulVunf6
         vyd3oP9gZYGzLh75HeVx95FBlSUIgW7a1zqYRCUbBz9GB6L7QTxxSUnRS7j4wvNXFuMt
         T2fy1j/q11UzhkGAKaievIysfxyclcHTvLxWm/I1Mv7J3fArsNX5xFSEgLMC9RxAm08S
         oByQ==
X-Forwarded-Encrypted: i=1; AKwUvBxmtGlZO1i06+Ai1GQY4HkKVglE+zHjqQV+5XnSL4m5VkMkT7NPPykMRHKc4xT6Aw+d9r/I54U1hOf08rbqtw==@lists.linux.dev
X-Gm-Message-State: AFq9FYIqIGNF8AP3jr735UB52ItlgQTdnjsPbSdQPCKOEOtnqNnt5JLK
	/x0rwuuLIpRig+gY85W0BbDp0Vja7v9Yq0kkQKKu7b2jnh41r7B1CcPQJLZvHXDQYCHDbo2xWJl
	8ScAabwIJcVZm3C82gPjxaWGfivjRZlM=
X-Gm-Gg: AYBFou0MyZM1wRD+4NeeIOEQdWgp7MBvcBfWHkMsze0XODb1h1kCpZ7dBfhK1DH0wjg
	QyMuqzNe5TFCZCltLEIGw5D9JaRrJqrENXgEslYa4A7fctRx8Hdg20LIaj3TfW1VWFrga8DOHAB
	FWjD27Vio/1SN1f8uN2rnmMNv97TexwfQ8FZPF/JbYqsElt8sURRPZbtq/SDqYob4J+JopQj3Sk
	w3nZOWOgR6rvh8Z4pTNJG6kI4fcHCn3Cn2ygJ4Obf6uEbPYWJeOlm/VU34idb6Sj6AGq2V5kd4S
	fHu9UuACwmJUUD+u5UaUzc0PzbBt+BWt6/Wy+ZfcW7+7rpEkg9sAPitqZA5lEI0wG/U=
X-Received: by 2002:a05:6870:8dcc:b0:46a:c673:a16c with SMTP id
 586e51a60fabf-49e15c87e4amr5548021fac.5.1791125017831; Sun, 04 Oct 2026
 07:43:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260928203445.72318-1-singhpra@juniper.net> <20260929074312.v3jT8uel@linutronix.de>
 <59d5452c-42b1-4784-a593-5e549a2a0f12@app.fastmail.com> <20260929151401.doOQX7D0@linutronix.de>
 <20260930013500.10273-1-singhpra@juniper.net> <20260930063217.eWGJ_JpZ@linutronix.de>
 <20261001012011.30525-1-singhpra@juniper.net> <4491d728-64f6-4ab1-aae2-22bce34a9b18@app.fastmail.com>
In-Reply-To: <4491d728-64f6-4ab1-aae2-22bce34a9b18@app.fastmail.com>
From: MaeeFilho FL <joaoanandalima@gmail.com>
Date: Sun, 4 Oct 2026 11:43:25 -0300
X-Gm-Features: AclHuK_mS1OrVdBt38iL83F6utRDrvJx_X_IRFzdoYUx1B03kcKmjAW9oBdsM3E
Message-ID: <CAFA5sMdHPz-H1EOw3y4RFjHMO9_ZmyV45SwvqF7wh8E4spKujg@mail.gmail.com>
Subject: Re: [PATCH v4] efivarfs: add nostatfs mount option to skip QueryVariableInfo()
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Prashant Singh <singhpra@juniper.net>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Jeremy Kerr <jk@ozlabs.org>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>, Steve McIntyre <93sam@debian.org>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prashant, Ard, Sebastian,

Regarding the concurrent update validation on efivarfs_reconfigure() and th=
e
KCSAN annotations discussed for the benign data race:

The implementation of data_race() directly wrapping the assignment of the
nostatfs flag inside the reconfiguration path is clean and highly efficient
for low-level standalone execution boundaries:

    data_race(sfi->mount_opts.nostatfs =3D new_sfi->mount_opts.nostatfs);

Since the reads inside efivarfs_statfs() and efivarfs_show_options() stay p=
lain,
this approach perfectly satisfies runtime instrumentation checks without ad=
ding
dead memory barriers or locking overhead to unprivileged statfs(2)/df routi=
nes.

Furthermore, preventing the global CPU stall caused by the SMM rendezvous d=
uring
QueryVariableInfo() on real-time environments (CONFIG_PREEMPT_RT) by defaul=
ting
to nostatfs is a major architectural improvement for deterministic scheduli=
ng.

For the final v5 patch spin, keeping the commit log focused on the preempti=
on
disabled context and dropping the verbose raw strace outputs as suggested
makes the patch documentation extremely tight and industrial grade.

Acked-by: dev12124 (Jo=C3=A3o Guilherme da Silva Freitas Lima)
<joaoanandalima@gmail.com>

Em dom., 4 de out. de 2026 =C3=A0s 04:59, Ard Biesheuvel <ardb@kernel.org> =
escreveu:
>
>
> On Thu, 1 Oct 2026, at 03:20, Prashant Singh wrote:
> > Thanks Ard and Sebastian for the comments.
> >
> ...
> >>AFAICT, that would potentially leave KCSAN instrumentation on the reboo=
t
> >>path, which might trigger and interfere with the reboot. So instead,
> >>I'd like to put this in efi_reboot_required if we can. If it is needed
> >>in more places to address an actual KCSAN splat, I don't mind. If it is
> >>just to make Sashiko happy, then we shouldn't bother.
> >
> > Could you please clarify what you mean by efi_reboot_required here? nos=
tatfs
> > is only read in efivarfs_statfs(), efivarfs_show_options() and
> > efivarfs_init_fs_context(), none of which run on the reboot path, so I'=
m
> > not sure how it would apply.
> >
>
> Apologies, I managed to completely confuse myself here. Forget what I sai=
d
> here, please :-)
>
> > On the annotation itself: an internal review flagged a potential KCSAN
> > data race rather than an observed splat -- statfs() can run concurrentl=
y
> > with a remount updating the flag, so it is a genuine (benign) concurren=
t
> > access. I ran concurrent statfs/remount loops on separate CPUs under
> > KCSAN and didn't trigger a report in a bounded run, which could be
> > expected given KCSAN samples accesses, so it doesn't disprove the race.
> > Since KCSAN only needs one side of the pair marked, data_race() on the
> > write covers both readers and the reads stay plain. I'm happy to drop i=
t
> > entirely if you'd prefer to keep the benign race unannotated.
> >
>
> No, let's keep it as you suggest.
>
> >>Please keep this description _here_ where you have it. Once this is
> >>merged, you could send another patch, extending the documentation with
> >>the statfs option (I think the workqueue change is in).
> >
> > Sure -- I'll keep it in Documentation/filesystems/efivarfs.rst for now
> > and send a follow-up extending Documentation/core-api/real-time/hardwar=
e.rst
> > once this is merged.
> >
> >>You still have the problem that someone reading the variable leads to
> >>the same problem but this requires a privileged user. And if I am not
> >>mistaken, someone sent patches to have efi-runtime runtime disabled/
> >>enabled.
> >
> > Agreed -- the variable-read path is the same, but needs a privileged
> > user unlike the unprivileged statfs()/df trigger.
> >
>
> Indeed - this is only about anyone with read permissions on the mount
> point being able to trigger this. And looking at your results, the
> rate limit we added recently might be a bit too permissive as well.
>
