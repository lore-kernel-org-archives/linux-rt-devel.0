Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210343B14AE
	for <linux-rt-devel@lists.linux.dev>; Thu, 17 Sep 2026 08:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789633518; cv=none; b=O2lEYV24OyF/tRXKVqOZOJaYYc/PXRgGg2ZnwtKYe08O853RwafAnKLHi1EysTg7YJOFr//gIaPJFLF1L3tN9HyEw+8IOQEFHDWh3qM2NKP1wmyTTI4HYo7k1opMBZUYhP4YRGEGAstNYFodVSHiiCb5Au/YMRbJPWQwIOOsPxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789633518; c=relaxed/simple;
	bh=xzCxCEzUowtsPxWMbDjD1lRzfaA5w83hr58sbAM2xcM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JDOueAS3RcQS2UZilAxNH8e9reM4aGkVrRldLOewp/HiYLHbFBQj+n1n8f3zsmRX9agz7Lg/sq/z/XdtGBW5OBs4oPPyAVFmlxTXB2z0JExLbufvZVGca/UreW2/w7xSr3Ycllva0XbDNGGkkIJzbk4iQQKAtYt0p6ojlZBwR+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4ab4f652f9bso494573b6e.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 17 Sep 2026 01:25:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789633502; x=1790238302;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uBkL6ZMYYdQOBhaz18ohIP2qWIBpLXjs4rOb70E61hY=;
        b=fW8Rvq5ude5uk72R1HwcXjVPPGegBaOWdpqbmR4kx1AMkWt84m/l+UA/zhYFw4GfDw
         J/T0HEevcRcIg2SSRofzUcN/+7ek5mtZswJbV9KBTPXVSGeMOTknWaPf5aRVcnnhq6fP
         j7kJkHNSbuYDtelhToL8LDwH0yJ5TyjfS43Oq5MU0xjDnexQ/DdfxC5cNOJTGPLZfvFh
         1P1S7dYXM7bkXgwTdluOmN3PTD544s72t5oLGQFANX2iXZa8v/yqIwp1YnM7grSs6JLQ
         9ggZSvEaNXTXG/angKo9K+M0jb6txy2qrv5mi4tfEgy5qFQHHoi4Wp/jGbj9pGHW4ZTo
         GbYA==
X-Forwarded-Encrypted: i=1; AKwUvBxdwzKz9MXq5OVISxTgQrRE65YkHZEnMmRvoBPAPeL/ailzLD8ztQTUV/E1cjuFPbHyRiIxcVmjirbHnHnYpw==@lists.linux.dev
X-Gm-Message-State: AFuF++mGVsRT8u+qckKzGno6JoqAnygMDNCWASHT8ti96Pndhk31uSRL
	UQiflHz4vp7HLNvUpJGdtYZ6WdieuXcSkVVTgMUkp8vqicbKrTrFjD5xsc2X38qwO8RMkGS+HV/
	D8jhyDE0F5Xiv+MfFNzSo8DOhzUPwpJSO8q4gkXhOtEAgATujjypkMQAz6s0=
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1692:b0:4c5:92fb:218d with SMTP id
 5614622812f47-4ca4be66e9dmr5399582b6e.22.1789633502228; Thu, 17 Sep 2026
 01:25:02 -0700 (PDT)
Date: Thu, 17 Sep 2026 01:25:02 -0700
In-Reply-To: <aqubuvR_2XCNav28@gremlin>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aaba3de.87c06881.1db2b3.0013.GAE@google.com>
Subject: Re: [syzbot] [kvm?] BUG: sleeping function called from invalid
 context in kvm_mmu_notifier_invalidate_range_start
From: syzbot <syzbot+c3178b6b512446632bac@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, bigeasy@linutronix.de, dwmw2@infradead.org, 
	dwmw@amazon.co.uk, kvm@vger.kernel.org, liam.howlett@oracle.com, 
	liam@infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-rt-devel@lists.linux.dev, ljs@kernel.org, lkp@intel.com, 
	llvm@lists.linux.dev, lorenzo.stoakes@oracle.com, me@brighamcampbell.com, 
	mhocko@suse.com, nogikh@google.com, oe-kbuild-all@lists.linux.dev, 
	pbonzini@redhat.com, rientjes@google.com, rppt@kernel.org, seanjc@google.com, 
	shaikhkamal2012@gmail.com, shakeel.butt@linux.dev, skhan@linuxfoundation.org, 
	surenb@google.com, syzkaller-bugs@googlegroups.com, vbabka@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c3178b6b512446632bac@syzkaller.appspotmail.com
Tested-by: syzbot+c3178b6b512446632bac@syzkaller.appspotmail.com

Tested on:

commit:         f902e69c sched: Allow sleeping spinlocks on PREEMPT_RT..
git tree:       git://git.infradead.org/users/dwmw2/linux.git seb-nonblock-rt-test
console output: https://syzkaller.appspot.com/x/log.txt?x=17d63bf9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8a263b38e64491d5
dashboard link: https://syzkaller.appspot.com/bug?extid=c3178b6b512446632bac
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
