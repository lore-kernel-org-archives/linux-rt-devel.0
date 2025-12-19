Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA135317709
	for <linux-rt-devel@lists.linux.dev>; Fri, 19 Dec 2025 11:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766143985; cv=none; b=tKd/J9rGiVFyR0GSpayeFaAO7M+jh8nesmSUlOdC7I+nLxxGza5VglAKtRDu3YGj+NbSLg8vFesQ/FZgY3gTgbpYzc1L+mqvACQcV20PPZabnmpZm0BqizjB2S9N37q2cd8R5ngb/sqDaO+3s5167MrnIQQi0eYDF+uJamBju5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766143985; c=relaxed/simple;
	bh=M6hvy/jCZMiK74z2GIEIrV8DdZf0DoXTol/OpIZNaCY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=btGh8bXNuiIHRowqExRyWDtI5h/U64rBtGsdbImCX/AO6y365mrBlSwALgmfMK0tHUIi9M3V8+M38cKYFrIevfunT1L1e48KVEJFVMPaUJ0XLLWXhFO5BZKfS4zmzQ+EIhM6OV3AHWsNm6L2PZ31xDhJbMqYsU13tNZ5DB96JL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zbd9OrxH; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zbd9OrxH"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4775f51ce36so15647855e9.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 19 Dec 2025 03:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766143981; x=1766748781; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hAAxcJSHCKa5e7JujPbI6PKo3xCnh6kgp+1s4KhQ0VM=;
        b=Zbd9OrxHHaMoGeAyFTZARVUdTc4PBHS3o+tIO89SmrVk6feeEpIgIssHONPfdCwVlp
         UAGrvl+e2JWDApou7AflIpDMbg5801jpEPL8pGN+OYFGbvPelYWKRnNtKXJ/M/9fiILa
         ptclx+N4+smE/DR4djMP4kHlAO7Ko0q6YYdJDP0JTQrP5ScBiIYK0/09/fOPCqdXIZq/
         XGEVDftSisJBM71Cx5TG9eQKqzQ2dLcdniYtO0pUjGct/Lk6qm9Xuvv2Sq68vA/zdK7f
         1lD2tjNzovnWCHh/Z+XV9GwEoc9RqQfS43Pc6zR/12Kj/HyW7ECOkcV17nhjaDVHNYwn
         EItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766143981; x=1766748781;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hAAxcJSHCKa5e7JujPbI6PKo3xCnh6kgp+1s4KhQ0VM=;
        b=n0OC0YrJs7zHJ68Q7xKfUoEOgOS2ilpUXaAxOuhbySOkHHPrE2Oe7hQkNFg7KTOUbd
         v5iji1nomyqiNaOS/2LwmSp0P2VjaXkfexSLB2NEAAlhJHkRIHNFFBji6OOfiCXahgZs
         oR74Eb6ACLOs3n6QJBMGogwMHow64ZKIKNnyB7Lue6OvC2kblsJ0Ecqic4DCy9/1ZoLc
         uIHbrZFfGvyLullETGB+Hkbd8G/wnIHVpHPWBKUA2gid51QGUJymR8l+gakbTfVNSIfd
         pj0XULg1cG6hqEmOaBS+wD6mJoWltowkrBH/w5HU8zcmOoKqO3N+7GI56Z5FcAAkbRrA
         dvzw==
X-Forwarded-Encrypted: i=1; AJvYcCUxpc8RCbjql7pEDgIEyN/nz/r/ny+E2cYVNmiCKVcY1+omIWJUrWJEoHXTnOkxf7Z6flU/Dk/y7M3ezv61Fg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxtyfOacOaPx+/jj3Impi8sU28HlXH0fmXqRKk8YNf016OvUScH
	lcPazU0fo2KfqEksb3/PkjbNDfi+03n7S6W+npGBmU/ErMRSbeImm3lp7E4UwptFWxG3wMLnAKT
	K0K9Ge+UfFIutnQ==
X-Google-Smtp-Source: AGHT+IFtEw/tE5Tma1oMoU1xWJDXu8dPIDS5WBCwLqxTONYM7wj02qZJ3F/C/QiLC8f4W8TibL2BPHLQh6Hw1g==
X-Received: from wmps26.prod.google.com ([2002:a05:600c:319a:b0:479:2d82:5535])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c08a:b0:46e:1abc:1811 with SMTP id 5b1f17b1804b1-47d197f67edmr16343165e9.27.1766143980920;
 Fri, 19 Dec 2025 03:33:00 -0800 (PST)
Date: Fri, 19 Dec 2025 11:32:18 +0000
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAME3RWkC/x3MQQqAIBBA0avErBvIKRd2lYgom2oWamhEIN09a
 fkW/2dIHIUT9FWGyLckCb6A6grsMfudUdZioIa0ImVw6XDfzmm+ghOLNjjH/sKWtdGN0qRaA6U 9I2/y/N9hfN8PG6QN7WcAAAA=
X-Change-Id: 20251219-b4-gfp_atomic-comment-3e5950152139
X-Mailer: b4 0.14.2
Message-ID: <20251219-b4-gfp_atomic-comment-v2-1-4c4ce274c2b6@google.com>
Subject: [PATCH v2] mm: clarify GFP_ATOMIC/GFP_NOWAIT doc-comment
From: Brendan Jackman <jackmanb@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

The current description of contexts where it's invalid to make
GFP_ATOMIC and GFP_NOWAIT calls is rather vague.

Replace this with a direct description of the actual contexts of concern
and refer to the RT docs where this is explained more discursively.

While rejigging this prose, also move the documentation of GFP_NOWAIT to
the GFP_NOWAIT section.

Link: https://lore.kernel.org/all/d912480a-5229-4efe-9336-b31acded30f5@suse.cz/
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
Changes in v2:
- Specified section in docs reference
- Link to v1: https://lore.kernel.org/all/DF0J58HOVLL4.2E16Q87D2UXRW@google.com/
---
 include/linux/gfp_types.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 3de43b12209ee79f84e7c9c919729303338433ff..814bb2892f99b829fde9b6dce1a317b3f29d01dc 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -309,8 +309,10 @@ enum {
  *
  * %GFP_ATOMIC users can not sleep and need the allocation to succeed. A lower
  * watermark is applied to allow access to "atomic reserves".
- * The current implementation doesn't support NMI and few other strict
- * non-preemptive contexts (e.g. raw_spin_lock). The same applies to %GFP_NOWAIT.
+ * The current implementation doesn't support NMI, nor contexts that disable
+ * preemption under PREEMPT_RT. This includes raw_spin_lock() and plain
+ * preempt_disable() - see "Memory allocation" in
+ * Documentation/core-api/real-time/differences.rst for more info.
  *
  * %GFP_KERNEL is typical for kernel-internal allocations. The caller requires
  * %ZONE_NORMAL or a lower zone for direct access but can direct reclaim.
@@ -321,6 +323,7 @@ enum {
  * %GFP_NOWAIT is for kernel allocations that should not stall for direct
  * reclaim, start physical IO or use any filesystem callback.  It is very
  * likely to fail to allocate memory, even for very small allocations.
+ * The same restrictions on calling contexts apply as for %GFP_ATOMIC.
  *
  * %GFP_NOIO will use direct reclaim to discard clean pages or slab pages
  * that do not require the starting of any physical IO.

---
base-commit: fc2af7a8060126c3a99fc1dfd7c5abd71a4dc81d
change-id: 20251219-b4-gfp_atomic-comment-3e5950152139

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>

