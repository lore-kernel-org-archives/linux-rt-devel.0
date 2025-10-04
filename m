Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AB08462
	for <linux-rt-devel@lists.linux.dev>; Sat,  4 Oct 2025 01:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759539845; cv=none; b=t3yg9/fAiYQe3DezPn3wy7Nty0GAgpPBFSzKNZ8Uwc7oATzAD7AVpEsNWNHJqklgN00d0llKAQMTKJDdT6XPL/ldULbA/YXDRS4JhWdQ3zVQ6hD8jxV7hAsu0VSP7/mnzJVLnxr7XBFanPjXQ+PcY8TzrMRYWRkVh90u99cwhOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759539845; c=relaxed/simple;
	bh=SOcgETh5xeubM838LXHr8nv9pfekOTux79h+0vKGLd0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HbMWl+Atha4iu/VVTBPo4uqPkONW6DRocgfKPylGZxwgoS+RwQHNpY01UyQQtVGlSekdoaWHfYj9ntkXnA14PbOMTsWtHa21rC+Sm7na4cIQJRwMrDaaGs4xJ89sjmcxMwDFMEpLP7zGTYrxwiGuH1Pfl7HCwbUEjK+qQRwp+kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8ccb7d90c82so363911339f.2
        for <linux-rt-devel@lists.linux.dev>; Fri, 03 Oct 2025 18:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759539843; x=1760144643;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HBSZwqSDmh1BSWgw4JtT806Jg7bQjBuA+gVX18qZT4E=;
        b=dbTAdk2MZToEtotGtyn03/BGF28fPrHfkJChlFKKrkEcKN8Ia2stpsrE41AnV58/vI
         qPFbTFsAusfcv8VQJ32/yr9NU2QpbmkFhFOYGIW3ugpu1tmjXwcAFYuBg1Ju+oYR4ech
         BtA9jlIaM8ZjiFUd4fFp0WxAYfMMFelzlFEnuyLC1q/Th7xxysH1f833OSbl9ZrMqTW9
         3kS+EMnSKVwAusSkRr56Ip+gLEAwfFIf2ZVeAnpWn2MI8EaGSPgWpJdvqP37ccHY8kDL
         XykW8glDTlfy7cHvWUPwz1xqIcYB7SL5z0x/IpiG306vhFcgU0vIzCih7lfbSDQJ8Qgp
         yL7g==
X-Forwarded-Encrypted: i=1; AJvYcCWXHcIIHqJ5toVtiXQVqufIJ7er/4IAzVJZ0Wbj1HZhK+siBlFSZmEDZF4YrEfXVVDzB4yn7rqtx+U3gSqpQw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyInHUwtSmIkHAJeBXc41R7yYwc4chPfOttCXOa6Hw/9erw7E8h
	5a6d7xdmRDarzdVTRPl+K8jOkHLpvVCrpaMMsGO2iONHpB2kg2IzjeSWjFjRe4FoOALUimZXhE4
	+f6TySJQbGeJwtmW9ClXpaNFk8Vwye4xSBRGs3HpY2iFjeon8h03UKMvnY48=
X-Google-Smtp-Source: AGHT+IG5JM3/o6FGfsB9hA9pW+iiPTtSAdodFWPBkviXe5k4KQ+1mesDPtmy+8ZNmTIw34B4iexXbVyss3CJ246tUdhyhjSRaavg
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a92:ca0d:0:b0:42e:6e3a:3075 with SMTP id
 e9e14a558f8ab-42e7ad84876mr59415045ab.21.1759539843090; Fri, 03 Oct 2025
 18:04:03 -0700 (PDT)
Date: Fri, 03 Oct 2025 18:04:03 -0700
In-Reply-To: <68c6c3b1.050a0220.2ff435.0382.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e07283.a00a0220.102ee.0118.GAE@google.com>
Subject: Re: [syzbot] [fs?] kernel BUG in qlist_free_all (2)
From: syzbot <syzbot+8715dd783e9b0bef43b1@syzkaller.appspotmail.com>
To: bigeasy@linutronix.de, boqun.feng@gmail.com, bp@alien8.de, 
	brauner@kernel.org, clrkwllms@kernel.org, dave.hansen@linux.intel.com, 
	davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, hpa@zytor.com, jack@suse.cz, kprateek.nayak@amd.com, 
	kuba@kernel.org, kuniyu@google.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, luto@kernel.org, 
	mingo@redhat.com, ncardwell@google.com, neil@brown.name, 
	netdev@vger.kernel.org, pabeni@redhat.com, peterz@infradead.org, 
	rostedt@goodmis.org, ryotkkr98@gmail.com, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de, viro@zeniv.linux.org.uk, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 3253cb49cbad4772389d6ef55be75db1f97da910
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Thu Sep 4 14:25:25 2025 +0000

    softirq: Allow to drop the softirq-BKL lock on PREEMPT_RT

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17566a7c580000
start commit:   7f7072574127 Merge tag 'kbuild-6.18-1' of git://git.kernel..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14d66a7c580000
console output: https://syzkaller.appspot.com/x/log.txt?x=10d66a7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b78ebc06b51acd7e
dashboard link: https://syzkaller.appspot.com/bug?extid=8715dd783e9b0bef43b1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ba76e2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17741ee2580000

Reported-by: syzbot+8715dd783e9b0bef43b1@syzkaller.appspotmail.com
Fixes: 3253cb49cbad ("softirq: Allow to drop the softirq-BKL lock on PREEMPT_RT")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
