Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56B741D105
	for <linux-rt-devel@lists.linux.dev>; Wed, 16 Sep 2026 19:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789586663; cv=none; b=khqXQNRwSNwZ3bJQrfIY7JJnTmojUpUPWGCUJllceJvF0WjLAZO089HiqpW7Ujr/eLqfPe2+tKhnJyLwaIUZq/4T7IoYjdrbZETSmoSQwImDBSEsnwzD8ZRcD1n1YmHN7HtvGUjg6c6Con1YG77BSrWokl1e/XjFmNSqIkVc000=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789586663; c=relaxed/simple;
	bh=T8e4qFcoWW/dNathKMvtjSc8MmQ0SvJgeeAGEMDyUMQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UwEV8rbHnSuJUO5jRvwUPlIC+vZzSJSO73n6P9oKHU3KLA3m2swJJ1Lr0M/CefkhWtntzrZm/Q7c3YW4sN7FaNDLxGqoKoFO41ISmTq9cbkkkfO5mcbcWMd6WxXMkGbNdqVv9vHCTjEulhsk0flBP5gRjmRZ5mA1FAD14L2BeSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4b2d1eb484aso134271b6e.2
        for <linux-rt-devel@lists.linux.dev>; Wed, 16 Sep 2026 12:24:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789586646; x=1790191446;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gGav+E6NmhUVSh9XUjVdcV/Auw85chnTv3eOmsCDzNk=;
        b=EV8TC3Ro5RpqYBGbmjd0vzYzGqJlU+U7DMtshB5sVdkousdF3L41EkPzetMHrrYIZg
         cwDMGqmtiq4jX4R2wfBx3kApLDcdpmWjjSrlweBnYWQKFMWpVYGf1AWJDw9qe64xKVcW
         XZS/+d5an8wP5PXZj8FWnjnb60To9VKrdaHDbi5wFMj9ye4gbwQ4oF1hhGy7pDQjvURe
         uLa/RE/+Ilmf0EW1k8iTGaXHTkEsMTJmbKgzZadnhB1OFiiUQiMff1pgG6s1IgnzVsiI
         nQCpxcdXzl/qoSn9SuZbY1bVPMNQbDFdbISQJY1qyPeaLHS4s0STKGZFReVRqK6Zb12z
         uvhQ==
X-Forwarded-Encrypted: i=1; AKwUvBxoKpEOsv5B34KPEl/PzbgtfdFT2tNFRoErsx7gB17RXa1X8defMbUKJ8WzUkZXElSwROgZ1buYoHnMsq50yA==@lists.linux.dev
X-Gm-Message-State: AFuF++lUDG02cJ26nOPDHg0p5trQFn5VJMG2PzYRaSUHHS5zbV7cXoWY
	3EvtVBcQhbu5/azEC3ReiYJIL+NZe0By4B8AQFgV30jdJqrLbTdPPDK9YmcR5IQDj8PYcYvTGKq
	tMTzjiTJuFqe1fFT2+CLOjE51WWXFn+oTvszSJRiEVk891iDj010vCu20AQ4=
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1a24:b0:4c3:7695:d30 with SMTP id
 5614622812f47-4ca4a1dc406mr4599160b6e.14.1789586646123; Wed, 16 Sep 2026
 12:24:06 -0700 (PDT)
Date: Wed, 16 Sep 2026 12:24:06 -0700
In-Reply-To: <aqrZMReaQPG0M9oV@gremlin>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aaaecd6.4e05fbd6.392abc.0003.GAE@google.com>
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

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
error: corrupt patch at line 7



Tested on:

commit:         9b87fdc9 Merge tag 'sched_ext-for-7.3-rc3-fixes' of gi..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=b454dc6b1b7acd30
dashboard link: https://syzkaller.appspot.com/bug?extid=c3178b6b512446632bac
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15a16bf9580000

