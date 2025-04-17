Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6AC13E41A
	for <linux-rt-devel@lists.linux.dev>; Thu, 17 Apr 2025 22:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744929234; cv=none; b=B4Enmsbfh1Kb4mqfgn9/uRwr2cn8B5QdGTq1xhx5VzPfF7Q9AB64oWiQQE5zYdWbUk9r7oNgHyn9GGPfcptkXZm8NKaEhgaHa2dKYVM6FeL39hkSUXYrLciLrWfzRODhBn0E0tV5EeEihnTRoFfWNaLfBuf3n0mSe8Q+1pS5ws0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744929234; c=relaxed/simple;
	bh=1+WGp7jt6wtHQuFVvTRgLK4SyIAYQphn2hiH4AWWyg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=En8gLXyAXsUzAvP+LyYcUhWxyCtmLxd0EBqnS/5v70o9eKqiVlFs8ZK7euYT07pSZbcuCp9Yg6uIfvHs3RLHDS0plwxZ9yOeGIDeJYx4LlX3E0inFlzCP/IazB+Zxmt6Pwf/oyaxgs6KZeq3UQ4Ho49vkEvRGW3P4bApADMEUwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K3ksqnw0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K3ksqnw0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744929231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j0E8sryxarxOaUI72XzRcIS2gIQk2T23BxOojM0ba14=;
	b=K3ksqnw0233Cf//MVjxZam9tgkwqYDADuonf8eHFAE5AtFg+BO0zC0jNtxLRW0K+wvNXUp
	cM01JY/+5Y7cGelW11imr8HX7QieNPlvquTZ9/uaLRgROGg46lx2YrFjc7LOceTcZ3IcTU
	Wly2lbMsneusO3NOVvaVs+uDbt34dsM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-T8jMqPBYNtm-HlMjZ-nhJQ-1; Thu, 17 Apr 2025 18:33:48 -0400
X-MC-Unique: T8jMqPBYNtm-HlMjZ-nhJQ-1
X-Mimecast-MFC-AGG-ID: T8jMqPBYNtm-HlMjZ-nhJQ_1744929222
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e90788e2a7so19259616d6.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 17 Apr 2025 15:33:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744929222; x=1745534022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0E8sryxarxOaUI72XzRcIS2gIQk2T23BxOojM0ba14=;
        b=fKIIzt9GirnbpGwcGnbpnvBJMwC/sOduGy1ouJM6MXPWyh2fQ7PljGSVgNVd8CuaHq
         Ngd1OMDYV6FKP6Jz97Fyf2Kbg/PGoBT0qEZQb48lFYXLufeaSPVNqnKiROexz94aiABg
         LTGfMC/Gz9XLByJ/wDvyGMV8MeCe/+gCMplMJTec/LtgorxgcDy6m5FruuI4UazhiGi7
         Z0v+yYFjwT0Oxf3rlX/jOJPTinmrGWHggow3ibAkYzzy3b3SXrlKaVnPtgBIS3BA7fT7
         YBQJPkeLMPYqcRKQml1sS5dZmJXcci3JHUsZpsw+B8eUzdOQwYiua9GxZwshyM4R9vSD
         gqqg==
X-Forwarded-Encrypted: i=1; AJvYcCVXBV/nOHTihO6AyF1p9gz4g7eHiiyenhK1cnpEfQUPKNhz3JPOj86vHzFRd3Y8moIhexuVo3cDt4qQGlTLzg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzocPt/e9zuYAKLLS9Z5fnMptdGPvtYAK6tvebsJKOtlclLwPMV
	zEqrdhz4fuaNEkY0nI92zC/BxTO9vFAKaLEFMIpyjA0vYoVJHJu4gKif/Q9GZW3UI1Fpo2WZwQQ
	EVW+JsDNTLs27OybMaX1xIWx6bXu4wasVg8H4kVs1q/EruGvRNpWj/KqRThQiEW64
X-Gm-Gg: ASbGncsXBS0G5mHR+g9dR9mwEUzoYoSZ6St5iTr8f+RukSGVuQSujjQ4vEt9K1XnTlR
	PYG792YzmXB/cnzbbyOKTzV8G2KOQzv8uu1p18Fkl5NQWVghl3d0aoJI25k2Rp2Tn672bPdkCwN
	ijjhfH+0V0s6vFLDNpg/vq4Au9IebfLZ2oK5JpBQ0lxLEF5RjgzpTsT9r+prSiG1gSzs/rIQbhk
	v/Uo8QBQmJuWDkxXLV50cpPSuWVYWuOK0gVsn+04azLqmrEBY1NvtQUucuiuesfTQckSvLKSbcU
	55A/bjdy4AwUBUyYLqUdqOEDPcrNbACQkK5dzeVJF5HBJYoRYmRC4bo=
X-Received: by 2002:a05:6214:3211:b0:6ea:ee53:5751 with SMTP id 6a1803df08f44-6f2c27d0d1cmr26705116d6.21.1744929222118;
        Thu, 17 Apr 2025 15:33:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2X8RM8WNcfj1JuzIKkInd7jY3kT/mXsTfOYbF5XSkRoRiDdP3awWZ2DMEc1SpzdRf9SEd5w==
X-Received: by 2002:a05:6214:3211:b0:6ea:ee53:5751 with SMTP id 6a1803df08f44-6f2c27d0d1cmr26704806d6.21.1744929221787;
        Thu, 17 Apr 2025 15:33:41 -0700 (PDT)
Received: from localhost (pool-100-17-21-114.bstnma.fios.verizon.net. [100.17.21.114])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2c3b8a0sm3853436d6.123.2025.04.17.15.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 15:33:41 -0700 (PDT)
Date: Thu, 17 Apr 2025 18:33:40 -0400
From: Eric Chanudet <echanude@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Ian Kent <raven@themaw.net>, Mark Brown <broonie@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ian Kent <ikent@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Alexander Larsson <alexl@redhat.com>, Lucas Karpinski <lkarpins@redhat.com>, Aishwarya.TCV@arm.com
Subject: Re: [PATCH v4] fs/namespace: defer RCU sync for MNT_DETACH umount
Message-ID: <3wy3sqvmun6ohamngwuxcquantwmk4ytcflm4jojbck4zjps45@jwsujs62sz2w>
References: <20250408210350.749901-12-echanude@redhat.com>
 <fbbafa84-f86c-4ea4-8f41-e5ebb51173ed@sirena.org.uk>
 <20250417-wolfsrudel-zubewegt-10514f07d837@brauner>
 <fb566638-a739-41dc-bafc-aa8c74496fa4@themaw.net>
 <20250417-abartig-abfuhr-40e558b85f97@brauner>
 <20250417-outen-dreihundert-7a772f78f685@brauner>
 <20250417-zappeln-angesagt-f172a71839d3@brauner>
 <20250417153126.QrVXSjt-@linutronix.de>
 <20250417-pyrotechnik-neigung-f4a727a5c76b@brauner>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250417-pyrotechnik-neigung-f4a727a5c76b@brauner>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8QpEpVNaCvlGKk9SA_UJOA1b-5owtEVMGOeKWZbFh-c_1744929222
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 17, 2025 at 06:28:20PM +0200, Christian Brauner wrote:
> On Thu, Apr 17, 2025 at 05:31:26PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2025-04-17 17:28:20 [+0200], Christian Brauner wrote:
> > > > (1) The real issue is with the same process P1 doing stupid stuff that
> > > >     just happened to work. For example if there's code out there that
> > > >     does a MNT_DETACH on a filesystem that uses a loop device
> > > >     immediately followed by the desire to reuse the loop device:
> > > > 
> > > >     It doesn't matter whether such code must in theory already be
> > > >     prepared to handle the case of seeing EBUSY after the MNT_DETACH. If
> > > >     this currently just happens to work because we guarantee that the
> > > >     last mntput() and cleanup_mnt() will have been done when the caller
> > > >     returns to userspace it's a uapi break plain and simple.
> > > > 
> > > >     This implicit guarantee isn't there anymore after your patch because
> > > >     the final mntput() from is done from the system_unbound_wq which has
> > > >     the consequence that the cleanup_mnt() is done from the
> > > >     delayed_mntput_work workqeueue. And that leads to problem number
> > > >     (2).

The following script runs fine on mainline, but consistently fails with
the version of this patch after discussions upstream:
  #! /usr/bin/bash -eux

  mntpath="/mnt"
  umount -R "$mntpath" || true

  fspath="/root/fs.ext4"
  dd if=/dev/zero of="$fspath" bs=1M count=500
  mkfs.ext4 "$fspath"

  loopdev="$(losetup -f "$fspath" --show)"

  for i in $(seq 0 99); do
      mkfs.ext4 -Fq "$fspath"
      mount "$loopdev" "$mntpath"
      touch "$mntpath/f1"
      umount -l "$mntpath"
  done
  losetup -d "$loopdev"

Failure looks like:
+ for i in $(seq 0 99)
+ mkfs.ext4 -Fq /root/fs.ext4
/root/fs.ext4 contains a ext4 file system
    created on Thu Apr 17 20:42:04 2025
+ mount /dev/loop0 /mnt
+ touch /mnt/f1
+ umount -l /mnt
+ for i in $(seq 0 99)
+ mkfs.ext4 -Fq /root/fs.ext4
/root/fs.ext4 contains a ext4 file system
    created on Thu Apr 17 20:42:04 2025
+ mount /dev/loop0 /mnt
mount: /mnt: mount(2) system call failed: Structure needs cleaning.

[    9.352478] EXT4-fs (loop0): mounted filesystem 3c5c632e-24d1-4027-b378-f51e67972883 r/w with ordered data mode. Quota mode: none.
[    9.449121] EXT4-fs (loop0): unmounting filesystem 3c5c632e-24d1-4027-b378-f51e67972883.
[    9.462093] EXT4-fs (loop0): ext4_check_descriptors: Checksum for group 32 failed (10605!=64170)
[    9.462099] EXT4-fs (loop0): group descriptors corrupted!

Seems worse than EBUSY :(.

> However, what about using polled grace periods?
> 
> A first simple-minded thing to do would be to record the grace period
> after umount_tree() has finished and the check it in namespace_unlock():
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index d9ca80dcc544..1e7ebcdd1ebc 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -77,6 +77,7 @@ static struct hlist_head *mount_hashtable __ro_after_init;
>  static struct hlist_head *mountpoint_hashtable __ro_after_init;
>  static struct kmem_cache *mnt_cache __ro_after_init;
>  static DECLARE_RWSEM(namespace_sem);
> +static unsigned long rcu_unmount_seq; /* protected by namespace_sem */
>  static HLIST_HEAD(unmounted);  /* protected by namespace_sem */
>  static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
>  static DEFINE_SEQLOCK(mnt_ns_tree_lock);
> @@ -1794,6 +1795,7 @@ static void namespace_unlock(void)
>         struct hlist_head head;
>         struct hlist_node *p;
>         struct mount *m;
> +       unsigned long unmount_seq = rcu_unmount_seq;
>         LIST_HEAD(list);
> 
>         hlist_move_list(&unmounted, &head);
> @@ -1817,7 +1819,7 @@ static void namespace_unlock(void)
>         if (likely(hlist_empty(&head)))
>                 return;
> 
> -       synchronize_rcu_expedited();
> +       cond_synchronize_rcu_expedited(unmount_seq);
> 
>         hlist_for_each_entry_safe(m, p, &head, mnt_umount) {
>                 hlist_del(&m->mnt_umount);
> @@ -1939,6 +1941,8 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
>                  */
>                 mnt_notify_add(p);
>         }
> +
> +       rcu_unmount_seq = get_state_synchronize_rcu();
>  }
> 
>  static void shrink_submounts(struct mount *mnt);
> 
> 
> I'm not sure how much that would buy us. If it doesn't then it should be
> possible to play with the following possibly strange idea:

Did not improve the lazy unmount, no corruption running the script.
QEMU x86_64, 8cpus, PREEMP_RT:
# perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs /mnt' -- umount /mnt
          0.019498 +- 0.000944 seconds time elapsed  ( +-  4.84% )
# perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs /mnt' -- umount -l /mnt
          0.020635 +- 0.000959 seconds time elapsed  ( +-  4.65% )

> diff --git a/fs/mount.h b/fs/mount.h
> index 7aecf2a60472..51b86300dc50 100644
> --- a/fs/mount.h
> +++ b/fs/mount.h
> @@ -61,6 +61,7 @@ struct mount {
>                 struct rb_node mnt_node; /* node in the ns->mounts rbtree */
>                 struct rcu_head mnt_rcu;
>                 struct llist_node mnt_llist;
> +               unsigned long mnt_rcu_unmount_seq;
>         };
>  #ifdef CONFIG_SMP
>         struct mnt_pcp __percpu *mnt_pcp;
> diff --git a/fs/namespace.c b/fs/namespace.c
> index d9ca80dcc544..aae9df75beed 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -1794,6 +1794,7 @@ static void namespace_unlock(void)
>         struct hlist_head head;
>         struct hlist_node *p;
>         struct mount *m;
> +       bool needs_synchronize_rcu = false;
>         LIST_HEAD(list);
> 
>         hlist_move_list(&unmounted, &head);
> @@ -1817,7 +1818,16 @@ static void namespace_unlock(void)
>         if (likely(hlist_empty(&head)))
>                 return;
> 
> -       synchronize_rcu_expedited();
> +       hlist_for_each_entry_safe(m, p, &head, mnt_umount) {
> +               if (!poll_state_synchronize_rcu(m->mnt_rcu_unmount_seq))
> +                       continue;
> +
> +               needs_synchronize_rcu = true;
> +               break;
> +       }
> +
> +       if (needs_synchronize_rcu)
> +               synchronize_rcu_expedited();
> 
>         hlist_for_each_entry_safe(m, p, &head, mnt_umount) {
>                 hlist_del(&m->mnt_umount);
> @@ -1923,8 +1933,10 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
>                         }
>                 }
>                 change_mnt_propagation(p, MS_PRIVATE);
> -               if (disconnect)
> +               if (disconnect) {
> +                       p->mnt_rcu_unmount_seq = get_state_synchronize_rcu();
>                         hlist_add_head(&p->mnt_umount, &unmounted);
> +               }
> 
>                 /*
>                  * At this point p->mnt_ns is NULL, notification will be queued
> 
> This would allow to elide synchronize rcu calls if they elapsed in the
> meantime since we moved that mount to the unmounted list.

Faster umount, lazy or not, no corruption running the script.
QEMU x86_64, 8cpus, PREEMP_RT:
# perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount  /mnt
          0.001482 +- 0.000121 seconds time elapsed  ( +-  8.17% )
# perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount -l /mnt
          0.002248 +- 0.000845 seconds time elapsed  ( +- 37.58% )

The crun test from v1 without your patch:
# perf stat -r 10 --null -- crun run test
           0.08166 +- 0.00476 seconds time elapsed  ( +-  5.83% )
The crun test from v1 with your patch:
# perf stat -r 10 --null -- crun run test
           0.01449 +- 0.00457 seconds time elapsed  ( +- 31.55% )

I have not run the LTP fs tests with that last patch yet, but that looks
like quite an improvement.

Best,

-- 
Eric Chanudet

