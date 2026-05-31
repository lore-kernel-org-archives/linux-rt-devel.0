Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5BC332EA2
	for <linux-rt-devel@lists.linux.dev>; Sun, 31 May 2026 14:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780237120; cv=none; b=iT1WQ1VoqDe1GHS62aRXM7GRpxZ1P6RgQ49VLFgy0Q4JjaQ/rOS6Wo1pPgkMErHJhreaH0ibmXL8ZTxG/RxcQAhkbiPnkmNlxk6PdABnH4CDIfqhVF3yuY76yDmJaSDNdVhQypGUpVzf2wvDS7MHHyrTHbTFEiJYOZ6ymG/Huvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780237120; c=relaxed/simple;
	bh=zjwsiyM9YIeiHH2wJ8jXDD9l5W0r7o7szymJ9KdY8Bw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=iVf9J9Ghz4OupEWX6X/F8xf0uq9DMPBYIuFAnR9L2gqABucYEORqwDWIPPWskRtEqxksuou9mhApqvI3egFHMDGNLV+TBYByZ3YQLX9IJPK8Sw+BXJF+4mCv/dpMiA4olIDH6SyglPR23oEPbgR3vIl6mkxnpEadykU3hBIqj+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oo6Hcj4j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oo6Hcj4j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780237117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QtO8FxV0FZvT6jbNOVRIHEka2WnDuWsEO9oX113DzcY=;
	b=Oo6Hcj4joTiL2yTRK84payEE6kR8X+5hIrkOXrJyF+yS9J3aAkGQAzRCUvGHZdXTDmUAAI
	eudoTOYf0At0SFKLA9WOhQqRMs1WsKUTwFwNHNCJquvFkCkVUda0OITP6ieZQsOveSyqbn
	k9lEpNaRatD1bF9Y27uIwBkucIsduVs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-ADeGhOcgOf6-nFFcCLxsQQ-1; Sun, 31 May 2026 10:18:36 -0400
X-MC-Unique: ADeGhOcgOf6-nFFcCLxsQQ-1
X-Mimecast-MFC-AGG-ID: ADeGhOcgOf6-nFFcCLxsQQ_1780237115
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490a7627763so5780695e9.0
        for <linux-rt-devel@lists.linux.dev>; Sun, 31 May 2026 07:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780237115; x=1780841915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QtO8FxV0FZvT6jbNOVRIHEka2WnDuWsEO9oX113DzcY=;
        b=aaRkzN+d1mJJSPfgrnx/IuZt2qGX0HXk1WXqO50rkto9sagFmdo8h4jIATDWf+1cUP
         HNChLE4RKjhFI3UVEaNOiLUiNU3MYHefuciM1s79WUxusko5Qu3lBIiplYDisvlZRHra
         lq1IXA+Aq9/o7S51F2IG6/xX76+AeoSt7FdvSEtPox1mL7fkLXBhOEfKjMI2XYn3nrfX
         QX6luTOlSq3beQ4PVcjMZWhkKcmBqmLQgnJr3AWgRq0pYFiTm4B2BPysiMCKrUtn7mhk
         PLPkCdGlCK1hRsM9jgwbmcwegIUpFpyY9WLLFDg3lOi7r3Z/zD34gEegUADeRU81Vy4u
         Hvqw==
X-Forwarded-Encrypted: i=1; AFNElJ/Kt6Eav4gU4BO114mDOS867CHVFZitTV8ky2P2eOJZqk2MSZNreFPOJl1ZRnBkNk8w4t/5UbU+9/E5larDxg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzci5qeLSX3ZDVPw584YiZIqrcXvHotM/f3tkU8Ktw+NhRnQwDN
	bjelAhZQ4/DAg4LbyYoG/w+xFsliPq2H0/bF6+qd2l+GnRQWiagcIs3ZJ8m2HloPeTndDhZcLoZ
	8iqiuo+F4UF+qajiTbfygvpQoqhjGtJJzjVVt2GZHhTo2Zt85HjWtc7TaNwI2sl6zI77f
X-Gm-Gg: Acq92OFYbPnVa/rFD+i8yUPnyBl9i05NvBPJH61GPj54mWoe+h/dQuRUYW4L5kpqKsR
	KHgHEvSqUPse1kwYSxMWdTuRMwrVQS7bFb6JQxkbgKHyWJWnIyoqmbk8hzw8JQuW2i3bt31pL2V
	iUXrY/yn7KxGXslskEtk54MBiZUCWRulb+L8WULbQi+xVFbZ/UWL5NNYIwSvtrAk89T1ctIr43d
	OtpXM6Zn7nFt/F9Zb81nowH/4KgQVaAsSj74edJKqsvLmihO9A9snrGzxWidsTzHjjCSgpvv5dp
	gXVSweG4qMx9RbfYnvTNL3H9NTlluJA2SY2AJA+BNvfu+2fFZRnfjy6eH1ePT5X9v0tO4gVL/OV
	C1bTqvc0ydlCWAItAJfDOSCG44leiOTQOPkTeCHuP8vfkIg==
X-Received: by 2002:a05:600c:46d1:b0:490:a7ab:bbe3 with SMTP id 5b1f17b1804b1-490a7abbd7fmr61900395e9.0.1780237114834;
        Sun, 31 May 2026 07:18:34 -0700 (PDT)
X-Received: by 2002:a05:600c:46d1:b0:490:a7ab:bbe3 with SMTP id 5b1f17b1804b1-490a7abbd7fmr61899935e9.0.1780237114475;
        Sun, 31 May 2026 07:18:34 -0700 (PDT)
Received: from costa-tp.bos2.lab ([2a00:a041:e223:1b00:fe51:8bb:7986:c897])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c0498e0sm76968165e9.0.2026.05.31.07.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 07:18:34 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-rt-devel@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Costa Shulyupin <costa.shul@redhat.com>
Subject: [PATCH v1] docs: real-time: Fix duplicated sched(7) text
Date: Sun, 31 May 2026 17:18:22 +0300
Message-ID: <20260531141823.4118954-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sQghkNXc0pIj1X_2YxcGKpCUyWDnrGPL1D0ifv6_mD4_1780237115
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The man page reference appeared twice - once as plain text and
once as a hyperlink. Remove the plain text duplicate.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 Documentation/core-api/real-time/theory.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/core-api/real-time/theory.rst b/Documentation/core-api/real-time/theory.rst
index 43d0120737f8..92de5654163d 100644
--- a/Documentation/core-api/real-time/theory.rst
+++ b/Documentation/core-api/real-time/theory.rst
@@ -25,7 +25,7 @@ Scheduling
 ==========
 
 The core principles of Linux scheduling and the associated user-space API are
-documented in the man page sched(7)
+documented in the man page
 `sched(7) <https://man7.org/linux/man-pages/man7/sched.7.html>`_.
 By default, the Linux kernel uses the SCHED_OTHER scheduling policy. Under
 this policy, a task is preempted when the scheduler determines that it has
-- 
2.53.0

