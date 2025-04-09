Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCEE26B959
	for <linux-rt-devel@lists.linux.dev>; Wed,  9 Apr 2025 16:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744216883; cv=none; b=QUBb4Xqm6XPSpe9zegZwhsQTUX3Fbh/r04pB5GInrFXkd58Jj6LPAk8YAwC05nyV6nY37sD/ZC4cy9XF7hj2kWXcLPpspTHyw7njSNBYQZyMjyU/KvSbP7nQdzc94NZLhYuAtw/hnKMoZ/YrcABQitY8EjgoNtk8GmZghcS3UuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744216883; c=relaxed/simple;
	bh=LFzjRlHP58WYddt2JQzoAgF2hPWegnLNbBxpK5k40fA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=S7UIBW3Hls98FNh3vucuSlWkRGuUKtGXynSQzu+c8NuxsZpelzskMDPXbIFlqjnDg7I+KKlR1nbwIk7YUtlDdyR8uyGCBDMjYxqceIlFa/5KS6kWnqVYTmBA3AZvoUuE8MiW3gUVnq6fGwTIKolg+DUtPSkrDwli89X7F77cALc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R4sk56S3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R4sk56S3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744216880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u36fvjFtGQQGPvbO3308W/6GduN68vFneYmXVnvzh1s=;
	b=R4sk56S3VLaGttxGnVWn5NAniSnH51zgdc+VsiHU6nM1cdpajZlpOzlFgK43iOPtrr65ek
	9MApEgOUDdOPdy99U3SREzW5c/QXzTb42KdFEwTdy65OWVUzhb8DTOzsYkTa/+5ptJpIoS
	7+BYi1Np3J6aDWI3xuY4uqn4yi+ph08=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-SSIHJdEBM8SjpDc6-x8IJw-1; Wed, 09 Apr 2025 12:41:18 -0400
X-MC-Unique: SSIHJdEBM8SjpDc6-x8IJw-1
X-Mimecast-MFC-AGG-ID: SSIHJdEBM8SjpDc6-x8IJw_1744216878
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-47779dbdb62so247300791cf.2
        for <linux-rt-devel@lists.linux.dev>; Wed, 09 Apr 2025 09:41:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744216878; x=1744821678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u36fvjFtGQQGPvbO3308W/6GduN68vFneYmXVnvzh1s=;
        b=jUWTW9IGgwQ7cFZk/dy+6s+BSbWihr8aMo3uuGKzjBFK7gTV/jQihEy2v5WtJSrqXp
         VjydYHKbzfUQG/IkyZMjvk7qb21iZ+QhIMYGK81mN96cDRgRqbcG9Bh4XF/TGLsZg4a/
         FaPx3XU872fMWsUS9K7KAEwsA8dgnX+7NCHxv5+MTD7ox3y8WHJybhf0t4ceHX66l7hM
         joyNF17tbxZi7wYERKoMqRlrI8OPlXxpZ8zxnhqiCmg7LeuJIOSyBltFMmqxPKeWH2C5
         0nhzmKXXOCuLxB/PffLtxzR9LEbNEk9sVZVP+ePEzQeEhlqE//IOObi/4akDhuQvJFQn
         5qqg==
X-Forwarded-Encrypted: i=1; AJvYcCXXzh1RMAVh9L5tUJ56NFK1BuaALenII/YJpZnA3F7A0KWATmgXnTKcBAOv5/9HcglCu74lyj3vOjOeGQQ4lg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz5jU0cd47Ly+H65hX8L2dLASSRCuBv9Eut2J2Qds8BAD8AiWmz
	4KlWDu0DdegTJFVG7fjkexdHyvF95Visyz7+B1j+AcsDOwwA1C1Td01zpOTfzoVVytW7DVEl4Bi
	EoYhh1tCdqiSFko4fg02xCsPpbF8Q9iPJUXNCL3oxLdjx6HKiLTKeSRtZWqTwVZCi
X-Gm-Gg: ASbGnctjpPl8MFoeDinU9WIHz3rfkSB4/+pLBx5gwVYT/IfDTWEzap0QPviSVwD7W3R
	S+njCudjbz/TttVPXxhNCPBbxOe8IeyME9a7fEq5fm03l7wClLaZS8tkVumvBS/zvxc3k4Rww6h
	Bv5187X2G/N6fpRTqhDjon4R+9EhmBFNpSvWHh2xgGWow0VS07ZX12W5xjDTM2t9rAlGC3VBVN/
	zTTPaIvQaNHnNWFQmxRyEr3SpSB24Vq+Uo4NgGEznkwkbs2Os1kudZO9u+NMZpX09WY+q+TdVAc
	B0cWbXxbeNQNir41HDnif0ks22+2rBoy0Oc8vEbMywMeqN9+iyzsVD8=
X-Received: by 2002:a05:622a:1a0c:b0:476:6f90:395e with SMTP id d75a77b69052e-479600a8a0emr50360361cf.21.1744216877738;
        Wed, 09 Apr 2025 09:41:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEO4Ll+hkTGnpbMHgI6Rh64gexYzHgzyCZesnMCv/qeydPl1RejXVPlhADf4PUXiDZhoJk95w==
X-Received: by 2002:a05:622a:1a0c:b0:476:6f90:395e with SMTP id d75a77b69052e-479600a8a0emr50360031cf.21.1744216877443;
        Wed, 09 Apr 2025 09:41:17 -0700 (PDT)
Received: from localhost (pool-100-17-21-114.bstnma.fios.verizon.net. [100.17.21.114])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47964d71a4esm9143961cf.2.2025.04.09.09.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 09:41:16 -0700 (PDT)
Date: Wed, 9 Apr 2025 12:41:15 -0400
From: Eric Chanudet <echanude@redhat.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ian Kent <ikent@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Alexander Larsson <alexl@redhat.com>, Lucas Karpinski <lkarpins@redhat.com>
Subject: Re: [PATCH v4] fs/namespace: defer RCU sync for MNT_DETACH umount
Message-ID: <fviov5jz4sga2qyexil57xz2egdjf2rz43qfr4jcozycgbovah@qptpvswdu2ia>
References: <20250408210350.749901-12-echanude@redhat.com>
 <mey7l4rm7r5fxndlg72jfjjwwctyoimjg35jetrnv5gbee4qll@w5ldyvm6h22a>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <mey7l4rm7r5fxndlg72jfjjwwctyoimjg35jetrnv5gbee4qll@w5ldyvm6h22a>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: adJQwwnVnS3Uxn3LSlWBXoWP_HJwpWO34mlSsXCcjjg_1744216878
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 09, 2025 at 03:04:43PM +0200, Mateusz Guzik wrote:
> On Tue, Apr 08, 2025 at 04:58:34PM -0400, Eric Chanudet wrote:
> > Defer releasing the detached file-system when calling namespace_unlock()
> > during a lazy umount to return faster.
> > 
> > When requesting MNT_DETACH, the caller does not expect the file-system
> > to be shut down upon returning from the syscall. Calling
> > synchronize_rcu_expedited() has a significant cost on RT kernel that
> > defaults to rcupdate.rcu_normal_after_boot=1. Queue the detached struct
> > mount in a separate list and put it on a workqueue to run post RCU
> > grace-period.
> > 
> > w/o patch, 6.15-rc1 PREEMPT_RT:
> > perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount mnt
> >     0.02455 +- 0.00107 seconds time elapsed  ( +-  4.36% )
> > perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount -l mnt
> >     0.02555 +- 0.00114 seconds time elapsed  ( +-  4.46% )
> > 
> > w/ patch, 6.15-rc1 PREEMPT_RT:
> > perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount mnt
> >     0.026311 +- 0.000869 seconds time elapsed  ( +-  3.30% )
> > perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount -l mnt
> >     0.003194 +- 0.000160 seconds time elapsed  ( +-  5.01% )
> > 
> 
> Christian wants the patch done differently and posted his diff, so I'm
> not going to comment on it.
> 
> I do have some feedback about the commit message though.
> 
> In v1 it points out a real user which runs into it, while this one does
> not. So I would rewrite this and put in bench results from the actual
> consumer -- as it is one is left to wonder why patching up lazy unmount
> is of any significance.

Certainly. Doing the test mentioned in v1 again with v4+Christian's
suggested changes:
- QEMU x86_64, 8cpus, PREEMPT_RT, w/o patch:
# perf stat -r 10 --table --null -- crun run test
    0.07584 +- 0.00440 seconds time elapsed  ( +-  5.80% )
- QEMU x86_64, 8cpus, PREEMPT_RT, w/ patch:
# perf stat -r 10 --table --null -- crun run test
    0.01421 +- 0.00387 seconds time elapsed  ( +- 27.26% )

I will add that to the commit message.

> I had to look up what rcupdate.rcu_normal_after_boot=1 is. Docs claim it
> makes everyone use normal grace-periods, which explains the difference.
> But without that one is left to wonder if perhaps there is a perf bug in
> RCU instead where this is taking longer than it should despite the
> option. Thus I would also denote how the delay shows up.

I tried the test above while trying to force expedited RCU on the
cmdline with:
    rcupdate.rcu_normal_after_boot=0 rcupdate.rcu_expedited=1

Unfortunately, rcupdate.rcu_normal_after_boot=0 has no effect and
rcupdate_announce_bootup_oddness() reports:
[    0.015251] 	No expedited grace period (rcu_normal_after_boot).

Which yielded similar results:
- QEMU x86_64, 8cpus, PREEMPT_RT, w/o patch:
# perf stat -r 10 --table --null -- crun run test
    0.07838 +- 0.00322 seconds time elapsed  ( +-  4.11% )
- QEMU x86_64, 8cpus, PREEMPT_RT, w/ patch:
# perf stat -r 10 --table --null -- crun run test
    0.01582 +- 0.00353 seconds time elapsed  ( +- 22.30% )

I don't think rcupdate.rcu_expedited=1 had an effect, but I have not
confirmed that yet.

> v1 for reference:
> > v1: https://lore.kernel.org/all/20230119205521.497401-1-echanude@redhat.com/

-- 
Eric Chanudet

