Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8249A26059F
	for <linux-rt-devel@lists.linux.dev>; Tue, 16 Sep 2025 04:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998111; cv=none; b=GMdLGmcvsKOJFOyF91M6lznC8HN4O50Tr7sDi8H2dEdH+NVbZTIyk2lnypMaBE9rtLf7YfAf51Kc8OSBd82I5cqZjkZymmRGe//3cT7GJKyKZ1wflJLq24kL/g/4rXrplaehk31LCdT3ECjabQTM/Qewy0CoN13fUgHnA+AMMDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998111; c=relaxed/simple;
	bh=ja+bbJPbRSrQwDXA6/q8IikecZ6d8Rw7OMDfeYI0NFk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gDk77YDvcGvA1lPDkdWqO6B6bVuPzLRwMeMngd75CiMlGqDpYhc786Jtd3gtlpXshWPKjzsGNiQla4ugr0cOjB5XcuAJBzv6AMf35TzqqbtctWGAqh5IWB7dzB292Uj8K2n+rX9DwJsjVTrNZ4bjNmt+SPH6bxrMzxezv0TGSZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmLUesrZ; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmLUesrZ"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b4cb3367d87so3290313a12.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 15 Sep 2025 21:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998108; x=1758602908; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4GnwUXvg4e1SjHBDj7IOnsANmiVf/8g2S4TikZ2k4g=;
        b=WmLUesrZm9scYnMIOpnrMuIaasZoNnF3Tmk37nInQaLAQ0WE7DXQ5I/lp0h5XdPA/a
         15jQCEgO+HuZzcmBquYN/p5ob3TAoLFsoN3yRNNCzpYkJMllSL1tEaW85rQOKHegiOfS
         KsAUDZIun4dQB6ryDkmwA3JL+t9P2InADanVAwtZfKyxAS9U4/PlK4+7HC5Eox+ZxQmv
         xhKxDwfQzR3wi2qe/oUrTyH7z3K/UD0z8db7RqUHi9GGhIsskdT/ilVPvNEXkhL/Lia+
         /CpuvgQFqIj52PDrSB1FlFsuIj1rNl7IDLYkBY7nVeEolqJapT+xPbr+Nl1/7/uevFZw
         2x7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998108; x=1758602908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4GnwUXvg4e1SjHBDj7IOnsANmiVf/8g2S4TikZ2k4g=;
        b=byVkkMRtidcx7KB/aLN1wtAgHHnaiapN7HQNVmm3eLheRwt42NIA3EXM59Z2ehoiag
         BfwXI1S1tdW8NGgOGwAYfRfkpq8Q/9kHMw9mbPQWbxE5OwaDdVQLEtuEX1dcY8UPda9w
         0C9R2stTpvHXADZezzTDr9ScxZoBDWRlIGlhFQnwYkiMMu2P7bHqJwamFZjhr6c/3fhR
         GoNbj0i2wpfsReVPa0bknIR2Bt+IF2RJw2chaSkNsAM+YoR+khIBtV5ZyWxDRMLaBY0/
         CEP4Vr4YYQEHUO8PLQUWfKjgIgkDdhCDjHh8u04+nRMeFzvNBKtEHmDKtjO05yH5ymul
         2yNQ==
X-Forwarded-Encrypted: i=1; AJvYcCX60lMZIIpw7sq+XHg+mtN9FTAGjEm+8jfbnXiXYv2cORHQKgWOZymXYiEMJPiCMGCLgQSLol3K+LNxzCenxw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyRUY6c3hWVk5lHn+PtS4JHgTJkKmfiIxmp7phraROQGIbZhpHJ
	JzNnEHHhBayrsx3Eb/F4jbEbW7D5OF0s4xQg7TdikxfzZDo5ytG7cxho
X-Gm-Gg: ASbGnctU5CAY7iA97UvQaldMvlVzwKbW7efswoWdZc67vNuS+aso3iAmLvvZrLCM4Xs
	y5lSHHzgR3arwpJziF8nVioEmRgiwO8VFcQjasKhdE7HMQGw0g5gi+qxZAi2NAVQWWAbAJxjsZU
	xi6TtQ5gT3A+ZOcB2hyzC15TsCjj9HZGrrpBXkKYCGUf0nrOAHIynASmBxKPoYT+BqlAu5z05yI
	7teeLml+3wTe5FA2UOlbu+9fs3W+IoBG+E8gJrelCzVq9hqw0xT9TzZahQ0WSo+oR/vwULsoM+a
	Le+ohVP7AmR2tbgr6aAgDhFrKEK5AWVmtl5i4tu2OSi99QL3mouJP3rMYTNGo9VqBcOJbvdBr6C
	wy8fw7roth/8QsaLC6v2gINSDHW3/FW2Rq7zG3Jc=
X-Google-Smtp-Source: AGHT+IEX+DuJO9pqL+sh6jlOJbx2wPh/MnPUcew7z+h1RxAPsxkAl191gDKewoy1JkBZ+L5tKb1L0g==
X-Received: by 2002:a17:902:ec8e:b0:25d:d848:1cca with SMTP id d9443c01a7336-25dd8481fbdmr195481725ad.35.1757998107572;
        Mon, 15 Sep 2025 21:48:27 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:48:27 -0700 (PDT)
From: pengdonglin <dolinux.peng@gmail.com>
To: tj@kernel.org,
	tony.luck@intel.com,
	jani.nikula@linux.intel.com,
	ap420073@gmail.com,
	jv@jvosburgh.net,
	freude@linux.ibm.com,
	bcrl@kvack.org,
	trondmy@kernel.org,
	longman@redhat.com,
	kees@kernel.org
Cc: bigeasy@linutronix.de,
	hdanton@sina.com,
	paulmck@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	linux-wireless@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-s390@vger.kernel.org,
	cgroups@vger.kernel.org,
	pengdonglin <dolinux.peng@gmail.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v3 02/14] drm/i915/gt: Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:23 +0800
Message-Id: <20250916044735.2316171-3-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916044735.2316171-1-dolinux.peng@gmail.com>
References: <20250916044735.2316171-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side function definitions")
there is no difference between rcu_read_lock(), rcu_read_lock_bh() and
rcu_read_lock_sched() in terms of RCU read section and the relevant grace
period. That means that spin_lock(), which implies rcu_read_lock_sched(),
also implies rcu_read_lock().

There is no need no explicitly start a RCU read section if one has already
been started implicitly by spin_lock().

Simplify the code and remove the inner rcu_read_lock() invocation.

Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 drivers/gpu/drm/i915/gt/intel_ring_submission.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_ring_submission.c b/drivers/gpu/drm/i915/gt/intel_ring_submission.c
index 2a6d79abf25b..bf73166a1337 100644
--- a/drivers/gpu/drm/i915/gt/intel_ring_submission.c
+++ b/drivers/gpu/drm/i915/gt/intel_ring_submission.c
@@ -392,14 +392,12 @@ static void reset_rewind(struct intel_engine_cs *engine, bool stalled)
 
 	rq = NULL;
 	spin_lock_irqsave(&engine->sched_engine->lock, flags);
-	rcu_read_lock();
 	list_for_each_entry(pos, &engine->sched_engine->requests, sched.link) {
 		if (!__i915_request_is_complete(pos)) {
 			rq = pos;
 			break;
 		}
 	}
-	rcu_read_unlock();
 
 	/*
 	 * The guilty request will get skipped on a hung engine.
-- 
2.34.1

