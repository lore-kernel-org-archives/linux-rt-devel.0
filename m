Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AA619B3CB
	for <linux-rt-devel@lists.linux.dev>; Mon, 30 Dec 2024 23:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735600745; cv=none; b=DHK3hGyXdCXIP0/rx1pOEVYqo9e3nAJec1HFi+BxPGmg3gGrqZ8jPyzj6f+uGP+UmN9Uu2vs7PzzUDV6S93DCF1n609IBJYTXTzZ/A4lSUi+YeMgde3YzwdUYXUcycDuisVHn7J+BGqRnGOtpixF1lkQYd5xlmPY8HkFwNZKYJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735600745; c=relaxed/simple;
	bh=vRI7372Q5Kne3rGvehqYNIqwTqXK973H3xAdZnjjOb4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XJzl3r4IV9XQDESKEn2IQU4o5tygcnDZzawP1rELhLS6kEOMZym4Rm70eVnvq7beGCzeSfWAX7sRbEJ/P3d8HPprB7N5bxIN6nnqCS0+BhmyiZha006AAbF4KfqlwxAe1Broq7VMyA8ToDR6+79PScWJapZ++A6UY1rmZaYUqIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a7e4bfae54so93624675ab.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 30 Dec 2024 15:19:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735600743; x=1736205543;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k4gh6TBXzpYDMGAqsRtjB7Y9Y365UNBzUT6dDnA4j+w=;
        b=aIoB/RqzMQLGSxVDtJWNcksw31KeXwjfJIqWGyn0wqX/ni539tkqajSJPeBaAzK6PL
         tHuVNhW57qRg+AXjilZz0hKa7XH0cGSztr0M+9wpoElZDera/RVy6NQqSZuAaznMaXyx
         W5nLPkvlVijWJiosCaEzJZJOPm8/wmDGVl0wTsVUjkc2MIlntv+AkBajmhCd60SGN2s4
         iur8Buua4MOAhR2YhGdpQfRh9Sxn0M9fvJ9xbxN1znAUEzVLz+1xs42wLXciUB3I9dVR
         3nlHVUcAMJLn7myMEAoTVjzpVMoP/wN+hiZR0987v+xSMQ2ci9ltvmGxggSHzfaADWvV
         KARQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbSjrXescpZFlRSc46VrwctCXiG2IzFSrtnbRjfgmb/GV9rm6hM/mW8uM6j6TXEUfP5zEQ21Zj401+xUn9WQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxQBzWfX8w7K2QzoosKYZnUHvwu6z5xJMokrUbvDimSWdCnXjt/
	lBsCXafCb7lh9qHjowEm+xyM4Hq6HBY7Bn7GLhHzbFI4XQrCYfx55fFyZr5JbHdAWgtaSk1DC7b
	VWBbclbnDNSTtNPsUb+RetxbYBEjLc/egPYsUsBw4dq9XcVN7Nn/2Wrg=
X-Google-Smtp-Source: AGHT+IEIAhjemoYtlUG/oMqIutmApQFIGArxjoU2/F2Ad7OHjg5+NYtNHUAvUX5Fh11pIhQeq4advX2MGG6fdBpqlArQc2sDIczi
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3687:b0:3a7:6d14:cc29 with SMTP id
 e9e14a558f8ab-3c2d18b43aamr342242215ab.1.1735600743208; Mon, 30 Dec 2024
 15:19:03 -0800 (PST)
Date: Mon, 30 Dec 2024 15:19:03 -0800
In-Reply-To: <616118a2-e440-45c6-a548-a1cdb1b586f2@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67732a67.050a0220.2f3838.04d0.GAE@google.com>
Subject: Re: [syzbot] [fs?] [io-uring?] WARNING: locking bug in eventfd_signal_mask
From: syzbot <syzbot+b1fc199a40b65d601b65@syzkaller.appspotmail.com>
To: asml.silence@gmail.com, axboe@kernel.dk, bigeasy@linutronix.de, 
	brauner@kernel.org, clrkwllms@kernel.org, io-uring@vger.kernel.org, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b1fc199a40b65d601b65@syzkaller.appspotmail.com
Tested-by: syzbot+b1fc199a40b65d601b65@syzkaller.appspotmail.com

Tested on:

commit:         a9c83a0a io_uring/timeout: flush timeouts outside of t..
git tree:       git://git.kernel.dk/linux io_uring-6.13
console output: https://syzkaller.appspot.com/x/log.txt?x=1566eaf8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50c7a61469ce77e7
dashboard link: https://syzkaller.appspot.com/bug?extid=b1fc199a40b65d601b65
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
