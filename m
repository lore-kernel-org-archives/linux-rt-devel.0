Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF44D3DCD9E
	for <linux-rt-devel@lists.linux.dev>; Wed, 18 Mar 2026 14:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773845046; cv=pass; b=occJPWPgl7DM6FaFt3Fht0tn4hR2D697F0s1uq4tl6uQ5kpyBDPpibo3UVUzkRxJI7193Uk4kASTfa4dQL2zXVwQ5mUIqCIG8zD2appWs4/k/YyjEdYpCLChTU+DVDH5NdPtxDF4L5uubt0bNTHqXRBpu2ymYIZ0fc2k+T8HZ1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773845046; c=relaxed/simple;
	bh=1vWGIGNakDqtlJkhrm20pGjTTl2ZGpSelhz88I5gY5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GOihM71bt4BS3jQkLi1MQSJIpJZ1joGZI8ULjxbEhgBpr9YCMHgTxERXlCl9dzuSLknS6iDa0vklJVJRpWhNtcF445OqXd46icEy+EGJ6RYht/1nCGtMgYzU0SlcUxrfG/jX7fxu6eZre4vuy43XAfVH2VkP1of5eMcoToyz4Ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gE/H2F3q; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gE/H2F3q"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439fe4985efso6117005f8f.3
        for <linux-rt-devel@lists.linux.dev>; Wed, 18 Mar 2026 07:44:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773845043; cv=none;
        d=google.com; s=arc-20240605;
        b=QwXb4A4kD89TCsd/dtAQ6mJiOAMHVzV/vWQajKTaapfkX7flK2Q0znTKjluntwrbYl
         FBmryj9vGDWQs2DtHOb7DJMyCfiiI4/DTvb1reLNFReaqNWV/GADTahRVWU0RPnDW1R/
         pVtHXB2NKn7KnY0XewBFrrFAQwPQeoSTWyCpWHGg9IEovPO9AUcQu9ghtPqNvdIEwn8v
         rKEREedIvWahExhPrCs8QZu8kEVvhyua3fRe8E3DqFcipS2JuQQh9GImKbYas2qw0jMX
         NcBKLoEYQiZrSsQAlN/aIdbku5MNUnruAsvp9KT5S453xsl9jsd3Q8RDQTbPFnMYbbft
         xvWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jMXohInzeoqakjhzYWU7cUPd1dT7sCRRVXjW4BqY0cg=;
        fh=eyB1/FOBjwnEWFA1bgwKCr2MTB+cykENxK5ZmDvZQYo=;
        b=ZxZTn+01+tCVcnNyqGKFsVGMQWA5yCwS7pHVndP57TV+m7Q/ymRTpi/IfHtJthZ+ig
         npeZK3/C84o6MbMARiyKky13WATaNWMCYa0VXHvTd1J8vOA8+uiHt8XTeErbmJi2w0sn
         xKKaJ5+V9J2XkoDmVqWYuM5gidZSW9enA496e3gchlBqGP7j7RPOgRpW6E0wZuTe8omg
         CDR7nZQb5nS8t77Jk8uwqurFMeXUnDJk6627Ol/Vn9lEvECqjgLdQFCUywN8Z5f9UHJw
         6NAx95h2X3ftpjES5YVLBfDXd0+w7RbK5/ftPuheJ/DowV/AinJJwIzWCx1EE3L4t8Lp
         725w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773845043; x=1774449843; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jMXohInzeoqakjhzYWU7cUPd1dT7sCRRVXjW4BqY0cg=;
        b=gE/H2F3qk/hq7rzq0jdOzZmY7fQhLGIoD4iP+pHL+YbHZnbcak2RPJDbLEDalxBWCM
         u1dajU4EeF54JwhKBM0KrllP9OpjtkNMFgdye1ggLWvvFTR50oEjfEhOL/aoQyXT02uB
         4d44IJKGg09x10ZEVK4+VpMBuA+xGvZpTA1t5bYpOGXBYyWSvWlxG8Xr2RRbV0Pod4hf
         5nX085AVI+kL+3MJg/5keolMPTefCfwLioPNn3LNICSJ/ljbWY2s0xnzBEXGbF7+oTLZ
         zSAEpY0ACxcUNXyh56Hlq36IlOE1igOFahR5It3fQg5JVL4ouHi2PweHlHq2STvZ1FWE
         BFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773845043; x=1774449843;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMXohInzeoqakjhzYWU7cUPd1dT7sCRRVXjW4BqY0cg=;
        b=NSIVL6SB9RAyOmS3Vo/4QxKa5vDBHDQNRjm5mbHvUKCRbYbQ4zVuJsRSpEqSCyV5cA
         iFgV+2REJohdH3PlZsEoAfFWCAWyAbKPBBcm71U/hsk7alBLzbjiWyQI/8F2TaVlxJ9G
         k2uyjwATBRTzMK3Aj2xBaTaQ15HDKuWpqy96L7enrcIqExmTm+5yPI+yyTRKpxzhbvi2
         7Ao/K1iNDi8rRKfT1mijxf1QBjKnQ1XZ2VOvXE39hetuIsJoCJ8HRobtXi3DPpaZjeZs
         rgExlC9pzcF8WssuR/xXXHSPBX7jHGfH8B/Io2glM4vD5jjHJSFK6XjRgkj7qgQ2lobd
         WIQA==
X-Forwarded-Encrypted: i=1; AJvYcCU2LMDH+ERKsC9P853i6rk5L36kTzbQ2NOxR/TocA7JeFMPtcBz7hZGwJYbtp+OYOH7k0yEqJRfyQm8MmkzrA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxkvG6TMsvGUeV8ihx+USpftYtTgbQgBBwvS9M6bvuMRT8LvQnA
	J4pUD7ROkI/Cr1whBXRdd73dWwyNbu//abcuPjvesx5xIXc1jIiQi50nR/BbnB6w+hyiXllT9Ha
	BbKAm+UBoJ1+bxM60HOLdk82/YwZ90IWbBxqjJimJEA==
X-Gm-Gg: ATEYQzytNcSjVdm+rHsuKcPWdWrKEtuAmnUQqupUPaeGg0Zjqmh30uwfMxEdVW2RSHb
	g6QV2C0FbKR32iN9KxVlPZHn3xci0q6pGWrcuq/Hk31l3EnqTSONMX0+N8JURqB4p6eLe8o3EGW
	sL/tHu+5lgsBJXFJWXEXEc4Zb5HsOyKxyo75+WZOp2wqpLG/T0ud5UUklQKG22qB+u/pa1gWOek
	Oct5vShR2O0qrrNZtKSkAxeTgqfP/93YcJy7eZEGTnrS1P84jU3w0akx3CHXhMJ+btc2NP/ameh
	zCj2tosUPqDZLhFwBBdgn2fiGfK1g432ceeCjtpYL2ImcmDuVWwu4t+nAgxCQ/WNqLWEj4t+NGV
	t0lRp
X-Received: by 2002:a05:6000:2302:b0:43b:5192:894b with SMTP id
 ffacd0b85a97d-43b527adde1mr6536659f8f.23.1773845043152; Wed, 18 Mar 2026
 07:44:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <80114792206dc00d0099f00999a209e717debb12.camel@web.de>
 <20260217095700.SjYjM8RO@linutronix.de> <4fba57892e5bd6a1afc4a36a80b40e3ecc28cac5.camel@web.de>
 <fd609cfe186ee48e0e9a08e35764175a2516dd14.camel@web.de> <2369ba83d204290dcfe157aed3f943206213b979.camel@web.de>
 <aa02f39ec4640c9d98963f42121b76e59b58371d.camel@web.de> <20260218073036.AlkNRoAP@linutronix.de>
 <ae213d2b908e46d34856be9daec891d7210f46f7.camel@web.de> <20260226172927.2Ck9wZMw@linutronix.de>
 <20260318103009.2120920-1-neelx@suse.com> <20260318111849._MMol8Hr@linutronix.de>
In-Reply-To: <20260318111849._MMol8Hr@linutronix.de>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 18 Mar 2026 15:43:52 +0100
X-Gm-Features: AaiRm51ceOk8VoveqAJnCirxUSK7B48kEkYDgq5_TgUOhULNInsCtDs8hn0BiCw
Message-ID: <CAPjX3FcRYNkYK2gerbRL4C9wXZPxWSs6=oTjzv5+msm4PQrfqA@mail.gmail.com>
Subject: Re: "Dead loop on virtual device" error without softirq-BKL on PREEMPT_RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, netdev@vger.kernel.org, spasswolf@web.de, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Mar 2026 at 12:18, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2026-03-18 11:30:09 [+0100], Daniel Vacek wrote:
> > > --- a/net/core/dev.c
> > > +++ b/net/core/dev.c
> > > @@ -4821,7 +4821,7 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
> > >             /* Other cpus might concurrently change txq->xmit_lock_owner
> > >              * to -1 or to their cpu id, but not to our id.
> > >              */
> > > -           if (READ_ONCE(txq->xmit_lock_owner) != cpu) {
> > > +           if (rt_mutex_owner(&txq->_xmit_lock.lock) != current) {
> >
> > Ain't this changing the behavior for !RT case? Previously, if it was the same thread
> > which has already locked the queue (and hence the same CPU) evaluating this condition,
> > the condition was skipped, which is no longer the case with this change.
>
> The above was me thinking and does not even compile for !RT. Commit
> b824c3e16c190 ("net: Provide a PREEMPT_RT specific check for
> netdev_queue::_xmit_lock") is what was merged in the end.

Hmm, that means txq->xmit_lock_owner is not used at all for PREEMT_RT.
It's pointless to even store it. Shall we care?

--nX

> Sebastian
