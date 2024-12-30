Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B2D1993A3
	for <linux-rt-devel@lists.linux.dev>; Mon, 30 Dec 2024 21:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735593563; cv=none; b=MGrlbZyJMPeHEKulurgfoZuhdcMBlnY1OE5qPZwHe+n7M+mhf1TBEB5zVWBjcfpdg4xmWGrcDdRiCBLTo4XE+WgkCHngAqYqOVOlzPDmg+58SqPB19MeRx9bxAvbHD/LWD4x34ncFNEoT5GvOZOvsYx0HI6Vm4m40ERAADAAG0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735593563; c=relaxed/simple;
	bh=0Ng/m/PsD2jQKEe2mMkN2J8F/tJmhS/LSZ9hggw1DNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YxcDNEWEsVxdgHevnrg/Cq4Qw+ev6MhuemND74UjwsApDvK9BuFyyN03dkmDem41bhMr/MBciN5cvNhAs2NKKSF6qXG+m21GWcMeOCwPE4eoZXfKsT+pL2vJ/D+Z5SBeMP/vc0m3NOG0BlU+pUa79Gz+0cUuD7gRfBSGc7O14ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=abARfy/J; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="abARfy/J"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-216395e151bso90872415ad.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 30 Dec 2024 13:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1735593559; x=1736198359; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2kY/jKKALg+6LJ3R04QO+vMeDW2e1LZ4lo7EHj/mvQ0=;
        b=abARfy/JIWtzNys5lM3jeulJbAbW6uxR3qqxfEX+pXFt8g8zmlLLqJnL3cGtwgNUbn
         7tSWD1Yq1spDMSgxNSYjFJ6aC24YUDoT/zSyLF8YtnO+U63PSy5DHD7B7WiPPZsopL2o
         BCzJgBrEdHEGpN3155W5wstVdBd9134fPU2ahyQE1+5Jd0g9Az5+Sd/oEpsKgfX/2WYP
         Hh33EqsnHYMOyHUuFNlMIjrOPLKcudhYgA2ukIiUNfiMylH7wPVOSq3hDAN4VxRBMckq
         9FVJGJyy2PLwS6Q8faGs66C5DFLlloRPI8G8bP50ONsYs1m+t37On/i3QsAFKCOejOBz
         F5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735593559; x=1736198359;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2kY/jKKALg+6LJ3R04QO+vMeDW2e1LZ4lo7EHj/mvQ0=;
        b=g/yHU+l0/UFCiV1iYnUj9Phn+SuL8MB2FVAU1mn2gsFiqy/H78Tt33+YYB/C2HXE9t
         DHVgoThgLeIcr7uis7cFXNMG42+hB6qvvbktK0QHWTNuAMsjlGu/8R9MYhhy7zdUl/cI
         65A1OzdomtgNj/88W+7DG/yGJjutJVa6DNadjKBC/0K91p5bThspAkVG/IUJaLn0E/rh
         iRmD81J2epWn8wa8ViS8Ui8+Wx9LsmzGW3qmxvB3lvU/GiWQvaDYtnbtCcZIKIUuz+ay
         rKUQ9XwcGQr/Bit0+b4bG94aXu0Guvu4ie3Ni4Q/VUqlzO5QqoB9H+zi3RdkC9ULZ/4Z
         8zfA==
X-Forwarded-Encrypted: i=1; AJvYcCURASumoJkB8i56C0BjOqjKRy6WTUeZy8FYrvC7Q8IqHePnV8X5sXO92voNvM4cMXXQk4dPWQDAfe9iFFMejw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz038Kcv6gD/gSpaHEgaPitViMlw5+bdzokiLRrtWcIGUgm3s3a
	YjHEuqb4JCxvPiVZ5WqtIPabXaL54JEHqZldhvhR5FFocbYzid0PjEH/HfkPoqA=
X-Gm-Gg: ASbGncsiJh5S2Ye2TOyv/tnu9y5NHRVsT0EW4YKT0h9370uDnp8JBreP8EmjQQ/sYsw
	ILjW2qclAgGtDonKLNabc6oqN+MBzimT0pFv5c1s+LTlYJoxQwghYX3OD+Q9g9KU3sQhy847mwh
	0rwA27lf1SKwmkB6RlZmT5yU7xz68OplBNonRhrLShTkW3MGR4RbGHGUqVcsVHqI4N4cw0RQnuQ
	04Oc8glpsWwvN5sfBUR5SNlcAEwZe+XcCBftWSZBD0e9d3NV+PBxA==
X-Google-Smtp-Source: AGHT+IEEW/98DMG+Ccn7tYKKNnYJKgJFri/6T1fdrEwHE8RgV3wfw0kXF1DnoCWXyGK9Cmsi+zGEAQ==
X-Received: by 2002:a17:903:32c1:b0:215:7287:67bb with SMTP id d9443c01a7336-219e6bf8c37mr495064155ad.0.1735593558999;
        Mon, 30 Dec 2024 13:19:18 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc962c1bsm183090255ad.3.2024.12.30.13.19.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2024 13:19:18 -0800 (PST)
Message-ID: <616118a2-e440-45c6-a548-a1cdb1b586f2@kernel.dk>
Date: Mon, 30 Dec 2024 14:19:16 -0700
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [fs?] [io-uring?] WARNING: locking bug in
 eventfd_signal_mask
To: syzbot <syzbot+b1fc199a40b65d601b65@syzkaller.appspotmail.com>,
 asml.silence@gmail.com, bigeasy@linutronix.de, brauner@kernel.org,
 clrkwllms@kernel.org, io-uring@vger.kernel.org, jack@suse.cz,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, rostedt@goodmis.org,
 syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
References: <67710fe0.050a0220.226966.00bd.GAE@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <67710fe0.050a0220.226966.00bd.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/29/24 2:01 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    9b2ffa6148b1 Merge tag 'mtd/fixes-for-6.13-rc5' of git://g..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=128f74c4580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d269ef41b9262400
> dashboard link: https://syzkaller.appspot.com/bug?extid=b1fc199a40b65d601b65
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1469890f980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154b22f8580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/9015cc2b19ac/disk-9b2ffa61.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/3ddeabd5e7eb/vmlinux-9b2ffa61.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/36e13b0305d0/bzImage-9b2ffa61.xz
> 
> The issue was bisected to:
> 
> commit 020b40f3562495f3c703a283ece145ffec19e82d
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Tue Dec 17 15:21:46 2024 +0000
> 
>     io_uring: make ctx->timeout_lock a raw spinlock

#syz test: git://git.kernel.dk/linux io_uring-6.13

-- 
Jens Axboe

