Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CD6146A9B
	for <linux-rt-devel@lists.linux.dev>; Fri, 24 Jan 2025 18:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737745195; cv=none; b=V+HAOjjTY+17/Ls8eK7/JCRF+r7WCr2NSViUo48Ef4+KFmMnczoLa9mNNbGZQiCKQU5Zb7cQp5EIL22AGdZiuQd/ChShnTSx96gEpxATA2ZIG4zMwFRvgBayXVchWD0fOGF+nak/LanCSJZghjInBaDrROvDvFzgiUmHCkz5Cfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737745195; c=relaxed/simple;
	bh=YzfI1cxrcQ4gKkhUAN32sqxN0mjY5GxvaycwvI41dHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rvty0x4ZW12X5vprDn9hCIyINMqNleSbM6QXJ9Yraa61y4L6o8kwE11H5kn/xNh7qNYcWpkEoOGufMr9W2tl9VVlZOdFTqs+RJ9iIvpiGEQeqz2uBdlY4iDgXKDOufeHQtgSLnmtAznsmXnZsidfgvhYU/z5sllDVQAmVuUG66Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cWJx6jxf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cWJx6jxf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737745192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fC3amORoEbT0AgVnrMEQKkuVrxKFmjCUr7fDTDZOcyc=;
	b=cWJx6jxfklTQw2DXLtQn/BfXL5WWcjGGYR7Mqg1fds4jZ+8Qf/JPLhelTeIHpsabWoIb2G
	qPGQJ8BcHW2eH3EX8QpI+mkzDZq/sMZ3TuQbDfMXZhyserFw09+cHEtZKWYi9eKoqB405F
	e8UHLyw4xLbcNHZ89t140GIvIZ4PZrQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-ZNMKpU3-P86vK7dDQ4xFqQ-1; Fri,
 24 Jan 2025 13:59:47 -0500
X-MC-Unique: ZNMKpU3-P86vK7dDQ4xFqQ-1
X-Mimecast-MFC-AGG-ID: ZNMKpU3-P86vK7dDQ4xFqQ
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 595041801F0F;
	Fri, 24 Jan 2025 18:59:45 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.88.114])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B201A1800344;
	Fri, 24 Jan 2025 18:59:42 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Feng Tang <feng.tang@intel.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 1/2] clocksource: Use pr_info() for "Checking clocksource synchronization" message
Date: Fri, 24 Jan 2025 13:59:22 -0500
Message-ID: <20250124185923.3610964-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The "Checking clocksource synchronization" message is normally printed
when clocksource_verify_percpu() is called for a given clocksource if
both the CLOCK_SOURCE_UNSTABLE and CLOCK_SOURCE_VERIFY_PERCPU flags
are set. It is an informational message and so pr_info() should be used
instead of pr_warn().

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/time/clocksource.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 7304d7cf47f2..77d9566d3aa6 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -382,7 +382,8 @@ void clocksource_verify_percpu(struct clocksource *cs)
 		return;
 	}
 	testcpu = smp_processor_id();
-	pr_warn("Checking clocksource %s synchronization from CPU %d to CPUs %*pbl.\n", cs->name, testcpu, cpumask_pr_args(&cpus_chosen));
+	pr_info("Checking clocksource %s synchronization from CPU %d to CPUs %*pbl.\n",
+		cs->name, testcpu, cpumask_pr_args(&cpus_chosen));
 	for_each_cpu(cpu, &cpus_chosen) {
 		if (cpu == testcpu)
 			continue;
-- 
2.47.1

