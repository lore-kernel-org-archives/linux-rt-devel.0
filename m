Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A528C15442A
	for <linux-rt-devel@lists.linux.dev>; Fri, 18 Apr 2025 21:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745011231; cv=none; b=UHg6I7flTY3sw3Dz6z3b2sxZI27LsH65fquwz56WpPW8eZQI+LpFtFJS2WmiIC9/xdHtFUsGh942l0YxhYgJjxM4VO9CXSAi7wt32fRxF/Dbf8jJqgHO/w/ggw8yFbseucR4yMu/K0Opy7OTwQx/EU9Ot/9tfNUdWJo73TbEyw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745011231; c=relaxed/simple;
	bh=2WbpYgZ5/1iPfOvqVQbS0/7r1TrUyPskBchwsqqeUOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UktXZONSFOg5SaYnbmW1yt2Jzez/St1bZ0mciU02Wsk2Ojx732d3i/I9eoXlNh+JHiLJjAf8KWu5AqVRzCAcQ7HIcm7Yb9gDrr3Bvy7Ob94GmP5Jh7o/a4c7KJ7SEo+L58jUdmZKwLcGfhN5l5+j4uqldfrGLoJzQ4Pz62hDanM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KKHZWT8w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KKHZWT8w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745011227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YLcSodfIPNzpSUVs/qbEk22ebWodmmpR5qEIAKLvngg=;
	b=KKHZWT8w5Gp3ifkodA561RP5XPjhc5Febu5ZWAoZNkXbrOIb9ceFtrp6k4dWGQcfDwtv6D
	fgdgjnMwLVKmgMhbu0/HHQ7uIHBXQRWaLthplkdtru+2OPAqrzRxj4UjC4VeuWWhcm5zXX
	7Co6QJVQSfbGTbZuwN1XXLS7QuFcxts=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-2K_0p05qPU--5zhu9Dxa3A-1; Fri, 18 Apr 2025 17:20:26 -0400
X-MC-Unique: 2K_0p05qPU--5zhu9Dxa3A-1
X-Mimecast-MFC-AGG-ID: 2K_0p05qPU--5zhu9Dxa3A_1745011226
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e8ec18a29aso23561776d6.2
        for <linux-rt-devel@lists.linux.dev>; Fri, 18 Apr 2025 14:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745011225; x=1745616025;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YLcSodfIPNzpSUVs/qbEk22ebWodmmpR5qEIAKLvngg=;
        b=rAKFt8DkvByr30rs3GIeOj+DxYzhicLvy0Ln7O8T+izdlxzQpCM9O26mFmRlIDdjjG
         lpFzPTZqoxOD2gqBSsD1bLbTLrcps/YYhQCg8V6lItl1DbY22WorU+htMN7ijyNcYhIo
         rbOLNpsz49OmEARNAaBdV/cFTl5i/q/JPcX5c4oKyDTAgJmtyR+FvaYoZJ9+xIGN8sna
         t9xHBK/XYPdyXGHdBYPswnlnj81QxEmU5of4mexphwW8Pzo28UFflJrlRNoW0aP8JudD
         E9/TW0fnuOGepIr9+Na1HWOYdwiOenlZeYqRqE+VWOcVH8qIq/uVBKK8SgWRLtJgxpgK
         HC3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFDmOWdGZBh1rrqRt1A5+cGJfAu5v6AdLB4RlUhqlq86zs6WHZAlfG1f4pRp+ilvWJFUZnKbojn7YQJ9j2Og==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx2OowcGHikxoeOFcepae47kwzydduZ1jYKIVJDhICVYC89k9qb
	nxQxV4vabdMBtRERmukA42nyGXQpEhCagud/WEqIlIRBiITRvvtdebSVZrOqkxfYHys1Z1Qq+LR
	H+Tvlizr/UR1uatSNj+kKKvf/c+ZD6RKmDOENxoYDwIewAQ1myZ+OrWIgbsBY5c5Y
X-Gm-Gg: ASbGncvYY74wt02XTHV77IBkppaGXXQ+HAYim1mMcQ+JyzprunCHLFNdYHR13XbpESh
	vpBmGxzclgwf9GgrX0SMskM6SsjVtARnFDiLpy5UeF9BeoW068Pma7UTmAlBGvLGHIsnRO977OH
	TikOW8VzVC0IodnTICnA6Mc4UvVUm8k8AZprdrc40ypQnk4d94R64cr1T4+ZE+GCWF6I3lsLHXa
	+R/4uK9vv/WeVIm6gixr/La30fzk+eJFqSQFSIbL+DoO+rg3IVdleH4j3KtnGS1qo1Lg3CUvA0u
	691gp6LtCfmKrPv3Q5oqqiN2tjqEcQZDp+xWPOA1+aGfIcsEfZKP3pw=
X-Received: by 2002:a05:6214:410e:b0:6e8:ddf6:d136 with SMTP id 6a1803df08f44-6f2c46754e1mr55883436d6.45.1745011225597;
        Fri, 18 Apr 2025 14:20:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+dz0v3NOFegBM/qOu2rfmKlj/svg+hgAxLxBAvRagHEQ/IWwiQxnORuAqhiodh71LnReyBA==
X-Received: by 2002:a05:6214:410e:b0:6e8:ddf6:d136 with SMTP id 6a1803df08f44-6f2c46754e1mr55883186d6.45.1745011225200;
        Fri, 18 Apr 2025 14:20:25 -0700 (PDT)
Received: from localhost (pool-100-17-21-114.bstnma.fios.verizon.net. [100.17.21.114])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2b0eb98sm14781266d6.40.2025.04.18.14.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 14:20:24 -0700 (PDT)
Date: Fri, 18 Apr 2025 17:20:23 -0400
From: Eric Chanudet <echanude@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Ian Kent <raven@themaw.net>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Mark Brown <broonie@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ian Kent <ikent@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Alexander Larsson <alexl@redhat.com>, Lucas Karpinski <lkarpins@redhat.com>, Aishwarya.TCV@arm.com
Subject: Re: [PATCH v4] fs/namespace: defer RCU sync for MNT_DETACH umount
Message-ID: <nsl2dc6qethzuurenxrbeesexeipqzasfddffgdkv54ynx352d@lzvffseimgym>
References: <fb566638-a739-41dc-bafc-aa8c74496fa4@themaw.net>
 <20250417-abartig-abfuhr-40e558b85f97@brauner>
 <20250417-outen-dreihundert-7a772f78f685@brauner>
 <20250417-zappeln-angesagt-f172a71839d3@brauner>
 <20250417153126.QrVXSjt-@linutronix.de>
 <20250417-pyrotechnik-neigung-f4a727a5c76b@brauner>
 <39c36187-615e-4f83-b05e-419015d885e6@themaw.net>
 <125df195-5cac-4a65-b8bb-8b1146132667@themaw.net>
 <20250418-razzia-fixkosten-0569cf9f7b9d@brauner>
 <20250418-armselig-kabel-4710dc466170@brauner>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250418-armselig-kabel-4710dc466170@brauner>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QCOgV6Ns9yhl-kazhHbr7EDcPngAg_tZrdprBUvVR8w_1745011226
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Apr 18, 2025 at 09:59:23PM +0200, Christian Brauner wrote:
> On Fri, Apr 18, 2025 at 10:47:10AM +0200, Christian Brauner wrote:
> > On Fri, Apr 18, 2025 at 09:20:52AM +0800, Ian Kent wrote:
> > > > On 18/4/25 00:28, Christian Brauner wrote:
> > > > > I'm not sure how much that would buy us. If it doesn't then it should be
> > > > > possible to play with the following possibly strange idea:
> > > > > 
> > > > > diff --git a/fs/mount.h b/fs/mount.h
> > > > > index 7aecf2a60472..51b86300dc50 100644
> > > > > --- a/fs/mount.h
> > > > > +++ b/fs/mount.h
> > > > > @@ -61,6 +61,7 @@ struct mount {
> > > > >                  struct rb_node mnt_node; /* node in the ns->mounts
> > > > > rbtree */
> > > > >                  struct rcu_head mnt_rcu;
> > > > >                  struct llist_node mnt_llist;
> > > > > +               unsigned long mnt_rcu_unmount_seq;
> > > > >          };
> > > > >   #ifdef CONFIG_SMP
> > > > >          struct mnt_pcp __percpu *mnt_pcp;
> > > > > diff --git a/fs/namespace.c b/fs/namespace.c
> > > > > index d9ca80dcc544..aae9df75beed 100644
> > > > > --- a/fs/namespace.c
> > > > > +++ b/fs/namespace.c
> > > > > @@ -1794,6 +1794,7 @@ static void namespace_unlock(void)
> > > > >          struct hlist_head head;
> > > > >          struct hlist_node *p;
> > > > >          struct mount *m;
> > > > > +       bool needs_synchronize_rcu = false;
> > > > >          LIST_HEAD(list);
> > > > > 
> > > > >          hlist_move_list(&unmounted, &head);
> > > > > @@ -1817,7 +1818,16 @@ static void namespace_unlock(void)
> > > > >          if (likely(hlist_empty(&head)))
> > > > >                  return;
> > > > > 
> > > > > -       synchronize_rcu_expedited();
> > > > > +       hlist_for_each_entry_safe(m, p, &head, mnt_umount) {
> > > > > +               if (!poll_state_synchronize_rcu(m->mnt_rcu_unmount_seq))
> > > > > +                       continue;
> > 
> > This has a bug. This needs to be:
> > 
> > 	/* A grace period has already elapsed. */
> > 	if (poll_state_synchronize_rcu(m->mnt_rcu_unmount_seq))
> > 		continue;
> > 
> > 	/* Oh oh, we have to pay up. */
> > 	needs_synchronize_rcu = true;
> > 	break;
> > 
> > which I'm pretty sure will eradicate most of the performance gain you've
> > seen because fundamentally the two version shouldn't be different (Note,
> > I drafted this while on my way out the door. r.

I failed to notice... Once corrected the numbers are back to that of
mainline, same as with the other version.

> > I would test the following version where we pay the cost of the
> > smb_mb() from poll_state_synchronize_rcu() exactly one time:
> > 
> > diff --git a/fs/mount.h b/fs/mount.h
> > index 7aecf2a60472..51b86300dc50 100644
> > --- a/fs/mount.h
> > +++ b/fs/mount.h
> > @@ -61,6 +61,7 @@ struct mount {
> >                 struct rb_node mnt_node; /* node in the ns->mounts rbtree */
> >                 struct rcu_head mnt_rcu;
> >                 struct llist_node mnt_llist;
> > +               unsigned long mnt_rcu_unmount_seq;
> >         };
> >  #ifdef CONFIG_SMP
> >         struct mnt_pcp __percpu *mnt_pcp;
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index d9ca80dcc544..dd367c54bc29 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -1794,6 +1794,7 @@ static void namespace_unlock(void)
> >         struct hlist_head head;
> >         struct hlist_node *p;
> >         struct mount *m;
> > +       unsigned long mnt_rcu_unmount_seq = 0;
> >         LIST_HEAD(list);
> > 
> >         hlist_move_list(&unmounted, &head);
> > @@ -1817,7 +1818,10 @@ static void namespace_unlock(void)
> >         if (likely(hlist_empty(&head)))
> >                 return;
> > 
> > -       synchronize_rcu_expedited();
> > +       hlist_for_each_entry_safe(m, p, &head, mnt_umount)
> > +               mnt_rcu_unmount_seq = max(m->mnt_rcu_unmount_seq, mnt_rcu_unmount_seq);
> > +
> > +       cond_synchronize_rcu_expedited(mnt_rcu_unmount_seq);
> > 
> >         hlist_for_each_entry_safe(m, p, &head, mnt_umount) {
> >                 hlist_del(&m->mnt_umount);
> > @@ -1923,8 +1927,10 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
> >                         }
> >                 }
> >                 change_mnt_propagation(p, MS_PRIVATE);
> > -               if (disconnect)
> > +               if (disconnect) {
> > +                       p->mnt_rcu_unmount_seq = get_state_synchronize_rcu();
> >                         hlist_add_head(&p->mnt_umount, &unmounted);
> > +               }
> > 
> >                 /*
> >                  * At this point p->mnt_ns is NULL, notification will be queued

That did not show improved performances.
ftrace confirms time is spent in synchronize_rcu as it used to, e.g:
 5)               |  namespace_unlock() {
 5)               |    cond_synchronize_rcu_expedited() {
 5)               |      synchronize_rcu_expedited() {
 5)   0.088 us    |        rcu_gp_is_normal();
 5)               |        synchronize_rcu_normal() {
 5) * 15797.30 us |        }
 5) * 15797.70 us |      }
 5) * 15797.94 us |    }
 5) * 15856.13 us |  }

(rcu_expedited=1 was mentioned upthread iirc, PREEMPT_RT discards it,
the trace above was with it:
# cat /sys/kernel/rcu_expedited 
1)

0001-UNTESTED-fs-namespace-defer-RCU-sync-for-MNT_DETACH-.patch yields
the expected improved performances, although I'm still seeing the
corruption reported earlier that doesn't happen on mainline.

> I'm appending a patch that improves on the first version of this patch.
> Instead of simply sampling the current rcu state and hoping that the rcu
> grace period has elapsed by the time we get to put the mounts we sample
> the rcu state and kick off a new grace period at the end of
> umount_tree(). That could even get us some performance improvement by on
> non-RT kernels. I have no clue how well this will fare on RT though.

0001-UNTESTED-mount-sample-and-kick-of-grace-period-durin.patch does not
show the expected performance improvements:
  # perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs /mnt' -- umount  /mnt
            0.022602 +- 0.000757 seconds time elapsed  ( +-  3.35% )
  # perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs /mnt' -- umount -l /mnt
             0.02145 +- 0.00130 seconds time elapsed  ( +-  6.05% )

Best,

-- 
Eric Chanudet

