Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4AD1DA109
	for <linux-rt-devel@lists.linux.dev>; Tue, 17 Dec 2024 14:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734445307; cv=none; b=rIVe6meSHMkAgcHCSkvR878z6dOxRXQV2yB6zlcAj7dJtwuOZK9RfrqaL6BFcix8my3/JPR2A/awtZSGpATO1SqbZ2q3gt8QFoROnHoo8I0nNSuGnivoZC6Hc/Naxp/Hco/DqpccCBy3WXjXRNvNXz6Qc1zjapK3r2xPfX7kJ5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734445307; c=relaxed/simple;
	bh=sWv5g63h/lelG/c0svQYP3qdi2ru2vaye3Lu8aYT+2M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-type; b=PVMf7JqOEF5YYsNCKuBKNaGJEmGcsCTFmOLztD3Wypf+MSqzeWdYBwGfVT6YVOiOhc0Jg1DOH5d9wRuu7n5+trKuplbdIM2E02ZDFWHzUkcrvbLH5FC/U6mW9anx4ZTMSp+ltiIbgnQWGQaNxJWLCPWCdgs8Bvn+imFHWV2F0MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=azoNqTfx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="azoNqTfx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734445304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8Dr2EHbX/y+fl2ClFkwVxyN+xWUTEC0vyjnXgy6CKlY=;
	b=azoNqTfxNsZgIoFsqYjLE3eImRWjjIak/iUl17WV78gtvdSBQNgISRclwrKO4W9TJ+BkpF
	gSrqmroF5xqIZxSVNzrLfGqb9tFsSmV13tozbmL5/54O9JxXPu89GxMfozWpnJrC/XLL6o
	GkArT3fk+EqxNJ5UnSWCehd7Ea+LLEA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-5KGhQVppOz-ux9V9hEB0FA-1; Tue, 17 Dec 2024 09:21:42 -0500
X-MC-Unique: 5KGhQVppOz-ux9V9hEB0FA-1
X-Mimecast-MFC-AGG-ID: 5KGhQVppOz-ux9V9hEB0FA
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385df115288so2240486f8f.2
        for <linux-rt-devel@lists.linux.dev>; Tue, 17 Dec 2024 06:21:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734445301; x=1735050101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Dr2EHbX/y+fl2ClFkwVxyN+xWUTEC0vyjnXgy6CKlY=;
        b=wcCA4YCtPekDVf8ftjmpdTuSeC8KlkyGpUnCBP4OdPYUG0IRduH6J1j8+cTr1v4U5O
         3GiVXLL4njzpxy7Z7hwoHQHXahgZumEhpS1ty5L8R01g2WjSGlBTU0QmXihiTiv5NIvX
         9RQuJXYDLmLO3YO05R2FND6XvDnUJZnD1Ug9RlInU9vZo/a+kPzfPxcQVqYOHjHXpbLo
         J1Tw0BokNJZShu0BX3620KkjJBkBbvLG3NS9/ZXYjyFe/NQ5xcpwmMlS3iJc+75etpgZ
         +gVQ8BBUL6HgwlN5VMzdTIj5StRVHyP6rMIwRPze0jY8o9LMpT5hVDFGXnI9zLLKfCaz
         nP0w==
X-Forwarded-Encrypted: i=1; AJvYcCWgTm8273d5nUzuQQAI3NzHp8nhEmI5MiamlyIAJwhWRe/fG7EnTxa+OynHcO5zn0Lkf2i5EO7Zg1Mw9WF81w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzr87uFF4FdfwQoKsbBmZOtmhy7okr9Su0CPGov2uIg9cIsBpNx
	1krhbX1GNmG2Kk1UN6BDta0AT3umkSKSayyrSGwAPsyLeakKPLDx4YZ00EFQY4bsx4t9H+6EbP6
	ykT4n/7kVeGZepqJO1StGnlscnuZuiiS7pKtTpHp5TGrRI0yF3nr8oOfDKuxLpV3r
X-Gm-Gg: ASbGncuiskDwkc0XH4mm1MgsRYgW+E2edcWetzS/wGNKC+51ztftuWgwG+4rPPA6n3J
	q12tASOgl3Q18KlCQvVJM9eX9cM5ktp0WuZXKeq1JhU0LvEsqFdFCD9xqZ9tj9sOYkGRjjylZF9
	gLjVa/dMWowNyjs0P9Fk+JBnCgwlHlHZMJ9sQUx6u3Vy6v9F/e0qRlwP3ZjXZeS0JvNmJTwd9ai
	0ZgY8x+lopiwOsyTiWJSBpUUEa6EKbSiIQGDmHkvA4G7Cx25KE6k905SVpqMA==
X-Received: by 2002:a05:6000:787:b0:385:f114:15bd with SMTP id ffacd0b85a97d-3888e0b8614mr13448729f8f.37.1734445300984;
        Tue, 17 Dec 2024 06:21:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuGTV7yX6OAyCGz+mhik59B+KccVwP+GQIMkxCeBkGgKnKosocOSTTeZKg4gnWSMhLmmy2fw==
X-Received: by 2002:a05:6000:787:b0:385:f114:15bd with SMTP id ffacd0b85a97d-3888e0b8614mr13448709f8f.37.1734445300580;
        Tue, 17 Dec 2024 06:21:40 -0800 (PST)
Received: from lab.hqhome163.com ([81.57.75.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4362557c57dsm173106295e9.12.2024.12.17.06.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 06:21:39 -0800 (PST)
From: Alessandro Carminati <acarmina@redhat.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: Alessandro Carminati <alessandro.carminati@gmail.com>,
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Gabriele Paoloni <gpaoloni@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Alessandro Carminati <acarmina@redhat.com>
Subject: [PATCH v2] mm/kmemleak: Fix sleeping function called from invalid context at print message
Date: Tue, 17 Dec 2024 14:20:33 +0000
Message-Id: <20241217142032.55793-1-acarmina@redhat.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ulq5Ep62gDGmgXQAPqtzYSvHO9W1CN7farLzTEOCOIo_1734445301
X-Mimecast-Originator: redhat.com
Content-type: text/plain
Content-Transfer-Encoding: 8bit

Address a bug in the kernel that triggers a "sleeping function called from
invalid context" warning when /sys/kernel/debug/kmemleak is printed under
specific conditions:
- CONFIG_PREEMPT_RT=y
- Set SELinux as the LSM for the system
- Set kptr_restrict to 1
- kmemleak buffer contains at least one item

BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 136, name: cat
preempt_count: 1, expected: 0
RCU nest depth: 2, expected: 2
6 locks held by cat/136:
 #0: ffff32e64bcbf950 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xb8/0xe30
 #1: ffffafe6aaa9dea0 (scan_mutex){+.+.}-{3:3}, at: kmemleak_seq_start+0x34/0x128
 #3: ffff32e6546b1cd0 (&object->lock){....}-{2:2}, at: kmemleak_seq_show+0x3c/0x1e0
 #4: ffffafe6aa8d8560 (rcu_read_lock){....}-{1:2}, at: has_ns_capability_noaudit+0x8/0x1b0
 #5: ffffafe6aabbc0f8 (notif_lock){+.+.}-{2:2}, at: avc_compute_av+0xc4/0x3d0
irq event stamp: 136660
hardirqs last  enabled at (136659): [<ffffafe6a80fd7a0>] _raw_spin_unlock_irqrestore+0xa8/0xd8
hardirqs last disabled at (136660): [<ffffafe6a80fd85c>] _raw_spin_lock_irqsave+0x8c/0xb0
softirqs last  enabled at (0): [<ffffafe6a5d50b28>] copy_process+0x11d8/0x3df8
softirqs last disabled at (0): [<0000000000000000>] 0x0
Preemption disabled at:
[<ffffafe6a6598a4c>] kmemleak_seq_show+0x3c/0x1e0
CPU: 1 UID: 0 PID: 136 Comm: cat Tainted: G            E      6.11.0-rt7+ #34
Tainted: [E]=UNSIGNED_MODULE
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0xa0/0x128
 show_stack+0x1c/0x30
 dump_stack_lvl+0xe8/0x198
 dump_stack+0x18/0x20
 rt_spin_lock+0x8c/0x1a8
 avc_perm_nonode+0xa0/0x150
 cred_has_capability.isra.0+0x118/0x218
 selinux_capable+0x50/0x80
 security_capable+0x7c/0xd0
 has_ns_capability_noaudit+0x94/0x1b0
 has_capability_noaudit+0x20/0x30
 restricted_pointer+0x21c/0x4b0
 pointer+0x298/0x760
 vsnprintf+0x330/0xf70
 seq_printf+0x178/0x218
 print_unreferenced+0x1a4/0x2d0
 kmemleak_seq_show+0xd0/0x1e0
 seq_read_iter+0x354/0xe30
 seq_read+0x250/0x378
 full_proxy_read+0xd8/0x148
 vfs_read+0x190/0x918
 ksys_read+0xf0/0x1e0
 __arm64_sys_read+0x70/0xa8
 invoke_syscall.constprop.0+0xd4/0x1d8
 el0_svc+0x50/0x158
 el0t_64_sync+0x17c/0x180

%pS and %pK, in the same back trace line, are redundant, and %pS can void
%pK service in certain contexts.

%pS alone already provides the necessary information, and if it cannot
resolve the symbol, it falls back to printing the raw address voiding
the original intent behind the %pK.

Additionally, %pK requires a privilege check CAP_SYSLOG enforced through
the LSM, which can trigger a "sleeping function called from invalid
context" warning under RT_PREEMPT kernels when the check occurs in an
atomic context. This issue may also affect other LSMs.

This change avoids the unnecessary privilege check and resolves the
sleeping function warning without any loss of information.

Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
---
 mm/kmemleak.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 2a945c07ae99..737af23f4f4e 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -373,7 +373,7 @@ static void print_unreferenced(struct seq_file *seq,
 
 	for (i = 0; i < nr_entries; i++) {
 		void *ptr = (void *)entries[i];
-		warn_or_seq_printf(seq, "    [<%pK>] %pS\n", ptr, ptr);
+		warn_or_seq_printf(seq, "    %pS\n", ptr);
 	}
 }
 
-- 
2.34.1

