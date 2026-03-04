Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D94353EE3
	for <linux-rt-devel@lists.linux.dev>; Wed,  4 Mar 2026 15:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772639438; cv=none; b=VPsFkoUbWgtNJwfbw0GDnfJcqZ2P0Xp/5yRSALDQoYwgyDWQ8iaz63iLayndxRBCaKiaY50Zjv9StpW3sP2SyuVOL+reDoHedNWMpqmXkLupp8Rtsif83MRz6yRsVxrc9YBKxQxTRD7BCCyLXcxV3/TrXdY3Rfpc7zX1q/wZs+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772639438; c=relaxed/simple;
	bh=srid6TqT8WkYW/1KRWVzJBN+Ggb8StLuZukw5flHfY8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PD/l+HOJSmzWptnsUE4GjlZ+NQLmEB3iENq+B9KR4QR1Egl1MQU4fy+RvffW+YevVJIv26L8LJ6V/JCxPbR9zZT4S+2JXN59J/VZVfjevV5vrra/gs2torZjDLqqFrMBd1pOd/6qJvfwmVWfyrSladhrI8b+gRjz7crTiQOH5Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Hm6ofjFo; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Hm6ofjFo"
Received: from ideasonboard.com (unknown [IPv6:2a00:6020:448c:6c00:404d:d4e8:ffdc:3995])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 027B1838;
	Wed,  4 Mar 2026 16:49:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1772639364;
	bh=srid6TqT8WkYW/1KRWVzJBN+Ggb8StLuZukw5flHfY8=;
	h=From:Subject:Date:To:Cc:From;
	b=Hm6ofjFoYIJzgIztk+IuvXeYHPmKq4X/vdktu8RzQq+bmDbDTNrDLrp2rLyamtTCN
	 7w8YXiq4U5s/QHfU9/7uFJZyhJmbnN0E+AWLKI8Ls/8TDRctc9v14QVZFTx+67qgK8
	 nUg2S0nFhjUIQcU+TSmc43fmH3YRKpQ5mUuLKBRE=
From: Stefan Klug <stefan.klug@ideasonboard.com>
Subject: [PATCH v5 0/4] media: dw100: Dynamic vertex map updates and fixes
 for PREEMPT_RT
Date: Wed, 04 Mar 2026 16:50:21 +0100
Message-Id: <20260304-sklug-v6-16-topic-dw100-v3-1-dev-v5-0-1a7e1f721b50@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL1UqGkC/5XQwU4DIRAG4FdpODsGhgXBk+9hemB3hpaoSwOVa
 pp9d2kv9mCT9fjP4fv/zFlULomreN6cReGWaspzD+ZhI6Z9mHcMiXoWKNFKJQ3Ut/fPHTQLysI
 xH9IEdFJSQtOggLjB6Iy15olG643ozKFwTF/Xitdtz/tUj7l8Xxubulz/gTcFEqwJUQ8kh0juJ
 RGHmucxh0KPU/4Ql46GNy7iChe7y0Ex+qjcFNUdV9+6foWru4s8GusMhyj9HXf4dRHX/GHortF
 GW5KO2P+1d1mWH/8tf5/fAQAA
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

This is an update of v4 that fixes a race condition that was introduced
in v2 of patch 1. That race only popped up now and could lead to a stuck
dewarper and system crashes in scenarios with high load and/or high
frame rates. See the changelog of patch 1 for further details. The rest
is unmodified:

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
Changes in v5:
- Fixed a nasty race condition in patch 1 (see local changelog)
- Link to v4: https://lore.kernel.org/r/20260225-sklug-v6-16-topic-dw100-v3-1-dev-v4-0-53536d08de91@ideasonboard.com

Changes in v4:
- Applied some style fixes and comments from review (see individual changelogs)
- Collected tags
- Link to v3: https://lore.kernel.org/r/20260129-sklug-v6-16-topic-dw100-v3-1-dev-v3-0-2eb5685eaf09@ideasonboard.com

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

 drivers/media/platform/nxp/dw100/dw100.c | 134 ++++++++++++++++++++-----------
 1 file changed, 89 insertions(+), 45 deletions(-)
---
base-commit: 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
change-id: 20260105-sklug-v6-16-topic-dw100-v3-1-dev-b856657db695

Best regards,
-- 
Stefan Klug <stefan.klug@ideasonboard.com>

