Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D83A352FBB
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Jan 2026 14:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769093104; cv=none; b=K8fjC1WJ4So/Z8f0ZRdjjJxDDXFj/K2GRimGdy6BTjs3hN/ZUvqurCZW9z+ZxDD66/kEQ6m2zDHiUqtHenUVm/PDIlz//DtuF8XKb6w6LkcRpEz1KgaRfqRcG+V1y+IZOLGyIjOswE3jzt3c8luGsPxLhFSJZu38K5/bbzOUvyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769093104; c=relaxed/simple;
	bh=8NJR3oSFIHdHjnKwbT16heNlQ/bMHJV731iVivoPk7A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kWFDvjxehmm4adEQxDNJx5w/dNeIPyl57TGXwpXGYBgXPRjSoj42IZ4cB4CutHaYeMbZbfHWGzGr3cUsWYcUnfE/RarsWoTbFoBH7ub0pBVODRBk4nwH506U/HXps0m90P6rLD2QrSyQ0hXi1BS2qPGsjAsefS9wyiMsCW0gT4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=EBr+U2I9; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="EBr+U2I9"
Received: from ideasonboard.com (unknown [IPv6:2a00:6020:448c:6c00:bc8e:214:d514:699a])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id CF828324;
	Thu, 22 Jan 2026 15:44:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1769093066;
	bh=8NJR3oSFIHdHjnKwbT16heNlQ/bMHJV731iVivoPk7A=;
	h=From:Subject:Date:To:Cc:From;
	b=EBr+U2I9iasF03DwI0XU8ZY5IW8IEQwVa/Fl2PvFfrw/ikLvPyUPbPDtrTggdA4iE
	 QWA9pzlcrHU2/il1rbVLTbvaiz6v7gtPlnlhKal1PqFEjnQXirEEKIJhL6zEzZg2C9
	 Ok1MXG0B1I3Qu0ZHwjprNomyKD4r02qqemLzulIg=
From: Stefan Klug <stefan.klug@ideasonboard.com>
Subject: [PATCH v2 0/3] media: dw100: Dynamic vertex map updates and fixes
 for PREEMPT_RT
Date: Thu, 22 Jan 2026 15:44:55 +0100
Message-Id: <20260122-sklug-v6-16-topic-dw100-v3-1-dev-v2-0-ea1e29f18cf1@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOc3cmkC/5WNQQ6CMBAAv0J6dk0LtCIn/2E4FHaBjUpJi1VD+
 LuVH3icOcysIpBnCqLOVuEpcmA3JcgPmehGOw0EjIlFLnMjldQQbvfnANGAMrC4mTvAl5ISYgE
 KkCK0lTZGn7A1Zy1SZvbU83tfXJvEI4fF+c9+jOpn/4hHBRKMtn1Roix7rC6MZIObWmc9Hjv3E
 M22bV+k/k0u1wAAAA==
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

Best regards,
Stefan

[1] https://lore.kernel.org/linux-media/20241022063155.506191-1-umang.jain@ideasonboard.com/

Signed-off-by: Stefan Klug <stefan.klug@ideasonboard.com>
---
Changes in v2:
- Use v4l2_m2m_buf_done_and_job_finish() for correct signal order
- Use dev_warn_once() instead of manual tracking
- Dropped threaded interrupt handler
- Renamed user_map_needs_update to user_map_is_dirty
- Link to v1: https://lore.kernel.org/r/20260105-sklug-v6-16-topic-dw100-v3-1-dev-v1-0-65af34d04fd8@ideasonboard.com

---
Stefan Klug (3):
      media: dw100: Implement V4L2 requests support
      media: dw100: Implement dynamic vertex map update
      media: dw100: Fix kernel oops with PREEMPT_RT enabled

 drivers/media/platform/nxp/dw100/dw100.c | 75 ++++++++++++++++++++++++--------
 1 file changed, 57 insertions(+), 18 deletions(-)
---
base-commit: 9ace4753a5202b02191d54e9fdf7f9e3d02b85eb
change-id: 20260105-sklug-v6-16-topic-dw100-v3-1-dev-b856657db695

Best regards,
-- 
Stefan Klug <stefan.klug@ideasonboard.com>

