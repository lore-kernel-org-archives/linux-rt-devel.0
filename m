Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7662C387358
	for <linux-rt-devel@lists.linux.dev>; Thu, 29 Jan 2026 11:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769686999; cv=none; b=ChhSyCItxxM5+n9LK2nY4xBB1LcVEJykMLJP+nLDsPvXiMj6jt0nBXUWDjffJMKgGeIsGaM3k7bGGv6jsHPZ794xgCGKIK/fovQbAPh4KEWXvtk1G2SZbsdTAAIwjuIQF1565Motj0XbZYdm1Qmk2d/+bB0b7BBIeAcj1HxL+V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769686999; c=relaxed/simple;
	bh=UrG4bu+oH5AW/Xtux/AJ1/QQ+pPPnyLbBMOXvTOu/60=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uZawmzCxq8vSpQlwC0p4em3XfyRI7Hh4UMV+9NT57SdIm96ONZ51Yi/TUn8n94IlgFIqTLrZ+Ys/EnawJSVG6VotzphY9PBd5OYLHMcFa8+M1uxBTaXNyRPRB5hs7gW3rrVUtZS8lhLDiK8a2lg99V/3v+kxEt19sTqVRdz6JDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=pvNAE3XW; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="pvNAE3XW"
Received: from ideasonboard.com (unknown [IPv6:2a00:6020:448c:6c00:f52e:2bba:80e9:14d8])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 1D2081661;
	Thu, 29 Jan 2026 12:42:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1769686957;
	bh=UrG4bu+oH5AW/Xtux/AJ1/QQ+pPPnyLbBMOXvTOu/60=;
	h=From:Subject:Date:To:Cc:From;
	b=pvNAE3XWusKqFOj0k5nxRSf8P6nBmGB7AAr+6LIDI8gP+Px/IeEJPWkKlPRvFZcdS
	 pj6TxvG26O5aO3pk8rNR1NuR3Qh4uOxjnkdg5dT7Hp6uZslm3/XlwWflyImpmWeBIv
	 NISFouOTR0j2GtWlYq5ZFnHkPNp6cmtf7zy659Dw=
From: Stefan Klug <stefan.klug@ideasonboard.com>
Subject: [PATCH v3 0/4] media: dw100: Dynamic vertex map updates and fixes
 for PREEMPT_RT
Date: Thu, 29 Jan 2026 12:43:09 +0100
Message-Id: <20260129-sklug-v6-16-topic-dw100-v3-1-dev-v3-0-2eb5685eaf09@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM1He2kC/5XNsQ7CIBSF4VcxzF7DpQWrk+9hHGi5VKKWBipqm
 r67tJODg47/Gb4zskjBUWT71cgCJRed73IU6xVrzrprCZzJzQQXiiOXEC/XewtJASoYfO8aMA/
 kHFIBCIYS1JVUSm5NrXaSZaYPZN1zuTiecp9dHHx4LY8J5/UPPCFwUFLbojS8tKY6OEM6+q72O
 phN429s/kjiwxXiB1dklzSS2FmsGotf3Gma3gYmrg4vAQAA
X-Change-ID: 20260105-sklug-v6-16-topic-dw100-v3-1-dev-b856657db695
To: Xavier Roumegue <xavier.roumegue@oss.nxp.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, Nicolas Dufresne <nicolas@ndufresne.ca>, 
 Stefan Klug <stefan.klug@ideasonboard.com>
X-Mailer: b4 0.14.2

Hi all,

This series contains a few updates to the dw100 dewarper. Patches 1-2
implement V4L2 requests support and dynamic updates of the vertex map.
This enables advanced use cases like interactive pan, zoom and rotate. A
first attempt to implement the dynamic update was posted a while back in
[1] but wasn't merged due to races in the implementation. By switching
to V4L2 requests the implementation is a lot simpler now.

Patch 3 fixes an issue on PREEMPT_RT enabled kernels.

Patch 4 does a bit of cleanup.

Best regards,
Stefan

[1] https://lore.kernel.org/linux-media/20241022063155.506191-1-umang.jain@ideasonboard.com/

Signed-off-by: Stefan Klug <stefan.klug@ideasonboard.com>
---
Changes in v3:
- Split the irq handler into two halves
- Added cleanup patch 4/4
- Link to v2: https://lore.kernel.org/r/20260122-sklug-v6-16-topic-dw100-v3-1-dev-v2-0-ea1e29f18cf1@ideasonboard.com

Changes in v2:
- Use v4l2_m2m_buf_done_and_job_finish() for correct signal order
- Use dev_warn_once() instead of manual tracking
- Dropped threaded interrupt handler
- Renamed user_map_needs_update to user_map_is_dirty
- Link to v1: https://lore.kernel.org/r/20260105-sklug-v6-16-topic-dw100-v3-1-dev-v1-0-65af34d04fd8@ideasonboard.com

---
Stefan Klug (4):
      media: dw100: Implement V4L2 requests support
      media: dw100: Implement dynamic vertex map update
      media: dw100: Fix kernel oops with PREEMPT_RT enabled
      media: dw100: Merge dw100_device_run and dw100_start

 drivers/media/platform/nxp/dw100/dw100.c | 129 ++++++++++++++++++++-----------
 1 file changed, 86 insertions(+), 43 deletions(-)
---
base-commit: 9ace4753a5202b02191d54e9fdf7f9e3d02b85eb
change-id: 20260105-sklug-v6-16-topic-dw100-v3-1-dev-b856657db695

Best regards,
-- 
Stefan Klug <stefan.klug@ideasonboard.com>

