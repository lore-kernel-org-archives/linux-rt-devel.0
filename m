Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A8530DEA5
	for <linux-rt-devel@lists.linux.dev>; Mon,  8 Jun 2026 02:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780885406; cv=none; b=fCQSCTzFIQ5rVJVlDj605YHjuYdACja+5Li4AXw1JNMrLXTe516IQQEUDBTqU6dXgcr8GsnSAdgiuKfUNgdGdLz2hUxLWrs3/1tPjqzy1d4q+mErAHBMtsIJuzb/gwPZefT71n3O0AHO82DK0T/sxfmFHi6xJto69VNOnuCMnOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780885406; c=relaxed/simple;
	bh=n2+mdFbtYQ31NrNEkjD04slJfvItRKfNpdTlLq81xZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=OoVupVMJ0V6AGvC5ee4jCyzXhNBOYzXpprEGW6Fm+9v4oKetkHuF+ZscZy8jB0RUAB3j+xZDBGWkiYSwdDor1g+pVzyzQDKey9fOD9EhSZN2C9FCfJsUlBwGrN+dYVYIKZcAQ8bAYM56EEhJmPs22jZGO+iSCItSAghDwa2R8EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yy4TkbgB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yy4TkbgB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780885403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wh8U2z/xEGIM07qppQ39zfhhwXF45bmOxQakpVSiksc=;
	b=Yy4TkbgBAZybwtpICY3lBH8yyAimnPZ0o8snnZotft16+giut1wgz2MKP3WtqJOE3dCfGQ
	z1dU5wA1lYKsnhtbEtEgDt6IcV9yOtY2GoFmSKwDypmFYuNcLB5AmROnK/4C8kyUdzYMKE
	0Wj/Qp2Mzhg6yFG79GVb609JEDpu8Xs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-zW_EA2qyMneaGw-i9GGwGA-1; Sun,
 07 Jun 2026 22:23:20 -0400
X-MC-Unique: zW_EA2qyMneaGw-i9GGwGA-1
X-Mimecast-MFC-AGG-ID: zW_EA2qyMneaGw-i9GGwGA_1780885399
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E6AEA180048E;
	Mon,  8 Jun 2026 02:23:18 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.88.52])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 22F9019560A2;
	Mon,  8 Jun 2026 02:23:16 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v6 0/2] debugobjects: Don't call fill_pool() in early boot hardirq context
Date: Sun,  7 Jun 2026 22:22:20 -0400
Message-ID: <20260608022222.723265-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: sQQ9D_BKDfvOWebCeFU_bpgPqOPGPLt_y-ezBdpl_Bs_1780885399
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

 v6:
  - Break the v5 patch into 2 separate patches with the first patch just
    adding a can_fill_pool() helper with no functional change as
    suggested by Ingo.

Patch 1 adds a can_fill_pool() helper to break down the conditional
check in debug_objects_fill_pool() to determine if fill_pool() should
be called into easier to read components.

Patch 2 fix the lockdep warning caused by calling fill_pool() in early
boot hardirq context.

These 2 patches together produce the same code change as in the v5 patch
[1]. So the Reviewed-by tag from Sebastian is kept in the patch 2.

 [1] https://lore.kernel.org/lkml/20260605173038.495075-1-longman@redhat.com/

Waiman Long (2):
  debugobjects: Add a can_fill_pool() helper for
    debug_objects_fill_pool()
  debugobjects: Don't call fill_pool() in early boot hardirq context

 lib/debugobjects.c | 46 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 9 deletions(-)

-- 
2.54.0

