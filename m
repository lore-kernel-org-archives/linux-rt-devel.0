Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B86F3A1E9F
	for <linux-rt-devel@lists.linux.dev>; Sat, 11 Apr 2026 15:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775922794; cv=none; b=Yrb5o+sDDGamXprBj6hg+lfT3sk9EhPm92J2WXTs9AiiCpcyuud2RnyTPzqwE1Azd9dVXGcJO4Orm9s5dObucsXJ4IRhshGGXPtm3MN53puTnZItP4KSufDVXiWaSgPYY1Z6TsjCxRFETKAMpHdtB6vUP/xuw3O0zpsWn0D0KH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775922794; c=relaxed/simple;
	bh=szNahsDdzfRYyvO/aj3g8rbqKjZFkB5X0HvgChFPezQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nNBbMkFp4w0OMRQ2As/QSScoKN90G1xAYRSkQDYOnEJiNpzBqqPaxZnBPfQaBH1E3zqQ+UbLTj0rWWr3j+wxvzscNN1Zem/PtJcwmGtoNeEgnyzcHEWn1iRK+fu4t/KpwyTj10RTGI9H+8GY9NY8JYgh2PmsXUCDfJYEF4QIWuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLUWYU9h; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLUWYU9h"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43cf5ad500fso2513913f8f.0
        for <linux-rt-devel@lists.linux.dev>; Sat, 11 Apr 2026 08:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775922791; x=1776527591; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ykIj77DYl2q5XauhI3fe9hKv77dgJXi8Oulhxw3fmt4=;
        b=PLUWYU9hPIbwVlzITGXeIOBJEG4PTIALbGIG5PLuROSR6sNr4h2620GZaIg4Ivtdsg
         nukV3jeq3Dz2CHCaOtwfnoCXj30EArc9o4WJUTTA8+eAqHcGcmoObB1LlCtrURwDAiBd
         u0/xG/pzZpc3OE8qhudNfL9Wel563X5Dn0LDuiCEsWN1VThlF9yangEgZd1FrZA+mkOQ
         3Z4oaoacXI7xIH7Nzd2aOL9oEKBcHHgYr250pa8Y9/YFqPLRLNUO3gvI9aaRv1l4iOTJ
         90LpuD4uGIL8p97cNrFfNkiU0m3vGRszhi745Pv/xuPKf0plZ1I84Nq/fhl9Z+04CMoT
         8wPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775922791; x=1776527591;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ykIj77DYl2q5XauhI3fe9hKv77dgJXi8Oulhxw3fmt4=;
        b=neyLuaUrbokrWhInQhtoywevTiHoUNVFpHxoiF9aYmbiHELS57OfddxP0bAEeMoSvA
         Cc7Ji/3dL//4sFJ3gWN6j+TcXWHWYpWJYn7hGG8njDjjPrYAMAYsrR/vbRVIrnkJYJJM
         E54q+Tgofw5vMWYvuyUXm40kQuGy2GDLRY0D7Mrc/cC4Alk4BloMC91gc8iBOIfZR88a
         KU/cyyVv33SdkqNrNsoYmhp0sfv30tRd8sl7peUGf3hXqzL6FymGQzge9MFfw2L0YeIJ
         0oMozykpwn5W+MkdB2ZtK99TRDCD0FJHOGGQ/9FP1vNfn/F8t3mX5f8mLqVLv/VqCj68
         EtAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHuOobn+TvwVzGThPNu+Z0E38KNbLxx2WjJOiF3KupQBlt/fGaun+A9wMHEZx2Kfgb1qHA4J3h2W94kTSSRQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTpQdkgwSzw3viQbdI+94R1CwXHMgERISBFk1ksUaRGK6I6Nt2
	sbtOXdwqsP6cxIw/kkDH6Ad6iWXoPTmz9rEGb4b0SuLuJqrpaUhi0Qg0
X-Gm-Gg: AeBDiesMMZ3JTcyZsz5/TpAZzgNK3NMUnsHxZeCE+5Mql5q7x9bt41/KZpgsfauzBLF
	d4DeyMJVIb0QyquvUCJneBEL4eCCzZ4VW07mmhiH9WV4oAtrnFrEZYpf0gOweezDlJjUiMWrQMp
	WU7fzOqmD//dyvvoUDqqZtw7Tt7dnS9Ok0FsQaWJSjN5WQuPEA6N4Fy8OvBtG/AVfDasxaF6q07
	IvHIqZ3c83L9bsAEn+O19sw2+huvzMTAWPjADb3/Zw9M+HkYIg563pSN8T+VYg8gPMRivKV4NCC
	zYCsR2ont1kyA26L15pHlNArrq9KWiS7R/sGT5C9g+MP/+vMdgfLIs/rE6BNqWkvtnrvVWdnla1
	OXBFN3TSHGNwJUA4PkaGJOBRt2YJ6rZgRHl7GlEiyBGLmmAE/J8M7uqqGQnIhsxLRJYZdHxG989
	suOSQ/7dQUxgGb+KliplamfJC9JdObLNTJweznMnCmXK8Tl8E0hgKsQ/Nv+3Gaei33CKgoWUbKe
	MugwNkNDZZlYFMOqpT87AvFl4ijKOi8uZ46ipu+/ozsxSrUP2PEmYANDgncSIttLgBCRxX3p8zw
	rUt1FwMbXr0zi7hloy8s6f1IEPV2E7Jh
X-Received: by 2002:a5d:5f92:0:b0:43c:fd7e:72eb with SMTP id ffacd0b85a97d-43d642cd31emr10983362f8f.41.1775922791535;
        Sat, 11 Apr 2026 08:53:11 -0700 (PDT)
Received: from hsukr3.localdomain (dynamic-2a02-3100-a01c-4800-fd8b-e688-91b6-420a.310.pool.telefonica.de. [2a02:3100:a01c:4800:fd8b:e688:91b6:420a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e46713sm17958153f8f.21.2026.04.11.08.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 08:53:11 -0700 (PDT)
From: Sukrut Heroorkar <hsukrut3@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-rt-devel@lists.linux.dev (open list:Real-time Linux (PREEMPT_RT)),
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Cc: Sukrut Heroorkar <hsukrut3@gmail.com>
Subject: [PATCH] Documentation: core-api: real-time: correct spelling
Date: Sat, 11 Apr 2026 17:51:19 +0200
Message-ID: <20260411155120.233357-1-hsukrut3@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typo "excpetion" with "exception".

Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>
---
 Documentation/core-api/real-time/architecture-porting.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/core-api/real-time/architecture-porting.rst b/Documentation/core-api/real-time/architecture-porting.rst
index c90a426d8062..c9a39d708866 100644
--- a/Documentation/core-api/real-time/architecture-porting.rst
+++ b/Documentation/core-api/real-time/architecture-porting.rst
@@ -74,7 +74,7 @@ Exception handlers
   Enabling interrupts is especially important on PREEMPT_RT, where certain
   locks, such as spinlock_t, become sleepable. For example, handling an
   invalid opcode may result in sending a SIGILL signal to the user task. A
-  debug excpetion will send a SIGTRAP signal.
+  debug exception will send a SIGTRAP signal.
   In both cases, if the exception occurred in user space, it is safe to enable
   interrupts early. Sending a signal requires both interrupts and kernel
   preemption to be enabled.
-- 
2.43.0

