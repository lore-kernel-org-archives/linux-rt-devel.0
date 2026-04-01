Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3DA47A0B4
	for <linux-rt-devel@lists.linux.dev>; Wed,  1 Apr 2026 16:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775062557; cv=pass; b=dHJXK9coC12smELyC05aSrMbIlwXE7IDgt7RCSqaY/48GrE76tg1+I6L7dSB85QLTNCULk9exP9M0FSsCVBHEFKho6+5DSNFuRZpTise3ujs3lqjB+dVEvMgt25Or0zMEesObOgjem6lexM3fsrQv0/g1idqRTko4R0R6VjdtKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775062557; c=relaxed/simple;
	bh=eO/Aj+ZtlXpxdIHMKMSgcDj7n5rRQmBw8M490hgHXi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MIv5xlizdbt5sNIfql6/uwHWcvoln5cIL8AhXRvHJFt/1KCLND0kgUx2wEFGnomnUr3YJW94R95GbK7wcS9Sxj+Rfo/yYQdE46DMKmfuPDWNxCf06K2r8gbEnN5vElzYRJA9Ped+oX7dn8wT8mbt1bTBVDWGpscA/O0ODs3IWpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bdD9R2S2; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bdD9R2S2"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43d17bb1c1dso774611f8f.2
        for <linux-rt-devel@lists.linux.dev>; Wed, 01 Apr 2026 09:55:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775062554; cv=none;
        d=google.com; s=arc-20240605;
        b=URdQNCkmPmWRCy6Jx5bOEYncc5rKNwFRAl8IYbxxzg24iWpsTfPz53OfjZDQ4S5G2V
         jmA3SkCFAecxejzsOVeAuQ6Lis+JbDan/8YVn1iyYE1MW1AIU+nlAasc1stPxmk8aeWH
         CV/SL6I6ZnDx1tu6DLd9naqBLX9YYpJGLEtH+OA5eXJBkT3efskmf9Z3q8dH2U8rRrjJ
         3W07oN+P2G6xgIc90UTscrHWii/JQiowHcBP97AeCwRpfXT8ylSYjcdp4iw29BfPvC7d
         cXngyRxTZeR9SttM+74ekC/VaEii769z3b3VQ9Bf6lDfZ63p3JfMlDq6cW9oBICJ8xpM
         D+pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1xx4YVdOSk31B8m52xPv3EMBRuAXgAy60np1RaxKVjE=;
        fh=WPXTZcdwP5teww0MVS6qnD195fwLIHcDR9le9/d8wZA=;
        b=Mx7oCKXr1gf+6IGrTUC9pWGaq4+KX83lZhEs+G7atRbynyIikZHgt+HdH+/o1HaAF2
         ganfbs2z98CIQnPhJt/Oebr65E7Gk38uFj3WekRPM1Hd7Y1j+0wibhtfWFkgb4HoWQmj
         HOcdwbGOwRHN9qNi6cs8VnrwQb+4cbOuSNb27V18xkmnMUXG4z6Evy5/y388m8Z43cXt
         nWHVD9vASVXCd2sgWuD9hs71rsZEoXTtEjlosAQp/oxZdTBIAWG2hthz5vtr/GoG1hgG
         wMryysvJPlv8+YMm3TUJBrkITMUnpgFvMkGJS1i1z9ARArG694cTqyRt7cI9P+0w8uYN
         /jvg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775062554; x=1775667354; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1xx4YVdOSk31B8m52xPv3EMBRuAXgAy60np1RaxKVjE=;
        b=bdD9R2S2sEcQ+ivAaUkri6BbEcnuDFutqVWp/41A2kIEoIfSPlVoUTRc59STHHeft7
         G8fXqiGM7IF2cblXLu4BahiqOIhUqOicL8umkvsy44c/7afSfbbdoECm5c6mwgDS3xjn
         +I9Xis1maMZOyNeCpqzepyLIwvx4HbFd0mq9hilkZ0XDcAui/DYG9bgiOAlljQS0WF+G
         zoszgGTNcWmWyVy3XnTk+R81JHNbejAXzyoBTJ2tLbTqm3Bziad2rmcRVainHHxXFOiK
         GutDtkaIrLeyvZk246VO+bjrBQ8oBb6QnndWr5UaJvgZMA7a1PAkdoAN4fy0NpFpsEIH
         i3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775062554; x=1775667354;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xx4YVdOSk31B8m52xPv3EMBRuAXgAy60np1RaxKVjE=;
        b=CPpxcvYj4ZfcYpbxreA7IvcZkBgIjtBjlUofuJBPmTxdi14qeqAVtcq18SIpLteipJ
         zschUtqvWhOsqbYEOVDoPNf6xNeAGsHjb4/55UVIpD1MTejpBNkQH+9pxSdl+4ymiNE9
         W6UUZOg7lgXqeMXkGPSrCE6XzoD2PBPl6LmPAUmYwrk7svM8sEdFY3Zo6jPO7OIO9cc0
         Ul12aZ6C3Y8d1Uz++SUcrBNOXE0x2A0aVGU3x12VRcEy7hDYlc1rOe1h9V3FwSLp18eu
         4H81vEcvjjTvxtTMW2SM3iQIekijW89rarUsH34YJQOWGTQkxBqEltFSHH3ht1Pk0CtZ
         9vAA==
X-Forwarded-Encrypted: i=1; AJvYcCXBDlWo+MTeweyZZoy41+iwch/w0/pVIhCUIFOpOHk6MYXRUfM5BZ/OZeZifhOL2aT2yaBayjGPoLiOwfC06w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy9Bm4bbBXC90rnWJ4JnA2xFQPVMk4qZIjrEX/tGbxO5aqXcod0
	dzvLGk/NQgM6+f6MmDPQyxkDJB7gFcawhETpNOZr2K0oVdV676MFTbe0yFd1RZAZ5TupipSuEX8
	3SVNOYtFVOzejwp6lQrPozNUxI+FHe/GCyB4xUDypcA==
X-Gm-Gg: ATEYQzwSzDgvTiZ3PbituPQlaCfWpzZjFhWAL5pC62syyF2xljZ4XKC1gFJs2rvFgTQ
	eh5A8BC6AI/oslJkmxaq7DKUq/bXOIl0Ig9vnpyxUVM90p+2XcdE9PoZeqcVWKXzTemc9+nW53w
	mYke2inc8zyHtwdv3S+ypUe4ykBI0ch/SFkkLZdFddCuY8bc84WKkEuVKsUqn7uOBF/RlpgRrRA
	9+BoLK5NDx5HrHFMbNZGxGx4UPQqtlHA15J7Ll0f4iTWKpuCDN+oP8Zv1pHkwelF+s4pzpObH3m
	8tO47gV3I00Yq6n0Mdal0J0Tyee8po46YZ66hTXReQ9VSQvaLF7smkt48aO+8B4H7ivRKJKw5kc
	FWCfA
X-Received: by 2002:a05:6000:601:b0:43b:3d44:6624 with SMTP id
 ffacd0b85a97d-43d1f1c03femr79938f8f.2.1775062554435; Wed, 01 Apr 2026
 09:55:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <4fba57892e5bd6a1afc4a36a80b40e3ecc28cac5.camel@web.de>
 <fd609cfe186ee48e0e9a08e35764175a2516dd14.camel@web.de> <2369ba83d204290dcfe157aed3f943206213b979.camel@web.de>
 <aa02f39ec4640c9d98963f42121b76e59b58371d.camel@web.de> <20260218073036.AlkNRoAP@linutronix.de>
 <ae213d2b908e46d34856be9daec891d7210f46f7.camel@web.de> <20260226172927.2Ck9wZMw@linutronix.de>
 <20260318103009.2120920-1-neelx@suse.com> <20260318111849._MMol8Hr@linutronix.de>
 <CAPjX3FcRYNkYK2gerbRL4C9wXZPxWSs6=oTjzv5+msm4PQrfqA@mail.gmail.com> <20260318145101._iaDDpbE@linutronix.de>
In-Reply-To: <20260318145101._iaDDpbE@linutronix.de>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 1 Apr 2026 18:55:43 +0200
X-Gm-Features: AQROBzCCROIdCe9kvHP9iYGHGkzUiotwHvSMgwQTbWweollZ6Da-pHq3fXh3bLE
Message-ID: <CAPjX3FePCKQTaxB6zuo+_V09PZct=utw3vgJUTM_GrZQtv7_TA@mail.gmail.com>
Subject: Re: "Dead loop on virtual device" error without softirq-BKL on PREEMPT_RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, netdev@vger.kernel.org, spasswolf@web.de, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Mar 2026 at 15:51, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 2026-03-18 15:43:52 [+0100], Daniel Vacek wrote:
> > On Wed, 18 Mar 2026 at 12:18, Sebastian Andrzej Siewior
> > <bigeasy@linutronix.de> wrote:
> > >
> > > On 2026-03-18 11:30:09 [+0100], Daniel Vacek wrote:
> > > > > --- a/net/core/dev.c
> > > > > +++ b/net/core/dev.c
> > > > > @@ -4821,7 +4821,7 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
> > > > >             /* Other cpus might concurrently change txq->xmit_lock_owner
> > > > >              * to -1 or to their cpu id, but not to our id.
> > > > >              */
> > > > > -           if (READ_ONCE(txq->xmit_lock_owner) != cpu) {
> > > > > +           if (rt_mutex_owner(&txq->_xmit_lock.lock) != current) {
> > > >
> > > > Ain't this changing the behavior for !RT case? Previously, if it was the same thread
> > > > which has already locked the queue (and hence the same CPU) evaluating this condition,
> > > > the condition was skipped, which is no longer the case with this change.
> > >
> > > The above was me thinking and does not even compile for !RT. Commit
> > > b824c3e16c190 ("net: Provide a PREEMPT_RT specific check for
> > > netdev_queue::_xmit_lock") is what was merged in the end.

Thinking about it again, wouldn't it be better to have one generic
solution rather then special-casing for PREEMPT_RT vs. !PREEMPT_RT?

--nX

> >
> > Hmm, that means txq->xmit_lock_owner is not used at all for PREEMT_RT.
> > It's pointless to even store it. Shall we care?
>
> For PREEMPT_RT the xmit_lock_owner member is only stored and not used
> otherwise. It could be removed as in ifdef-ed away but I do not care
> enough to sprinkle it and the gain is little (proof me wrong). So I am
> happy as-is.
>
> As for the check itself as we have now, we detect the deadlock before it
> happens and this is nice to have. The alternative (in case of a
> deadlock) would be the deadlock detection in rtmutex code which would
> freeze the thread.
>
> > --nX
> >
> Sebastian

On Wed, 18 Mar 2026 at 15:51, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2026-03-18 15:43:52 [+0100], Daniel Vacek wrote:
> > On Wed, 18 Mar 2026 at 12:18, Sebastian Andrzej Siewior
> > <bigeasy@linutronix.de> wrote:
> > >
> > > On 2026-03-18 11:30:09 [+0100], Daniel Vacek wrote:
> > > > > --- a/net/core/dev.c
> > > > > +++ b/net/core/dev.c
> > > > > @@ -4821,7 +4821,7 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
> > > > >             /* Other cpus might concurrently change txq->xmit_lock_owner
> > > > >              * to -1 or to their cpu id, but not to our id.
> > > > >              */
> > > > > -           if (READ_ONCE(txq->xmit_lock_owner) != cpu) {
> > > > > +           if (rt_mutex_owner(&txq->_xmit_lock.lock) != current) {
> > > >
> > > > Ain't this changing the behavior for !RT case? Previously, if it was the same thread
> > > > which has already locked the queue (and hence the same CPU) evaluating this condition,
> > > > the condition was skipped, which is no longer the case with this change.
> > >
> > > The above was me thinking and does not even compile for !RT. Commit
> > > b824c3e16c190 ("net: Provide a PREEMPT_RT specific check for
> > > netdev_queue::_xmit_lock") is what was merged in the end.
> >
> > Hmm, that means txq->xmit_lock_owner is not used at all for PREEMT_RT.
> > It's pointless to even store it. Shall we care?
>
> For PREEMPT_RT the xmit_lock_owner member is only stored and not used
> otherwise. It could be removed as in ifdef-ed away but I do not care
> enough to sprinkle it and the gain is little (proof me wrong). So I am
> happy as-is.
>
> As for the check itself as we have now, we detect the deadlock before it
> happens and this is nice to have. The alternative (in case of a
> deadlock) would be the deadlock detection in rtmutex code which would
> freeze the thread.
>
> > --nX
> >
> Sebastian
