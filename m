Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD01E38F931
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Feb 2026 15:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772034654; cv=none; b=JmT4KBUB3/N8gdaK/paHiXi7e+q6DlWgvxHZ5XffEEJS+untA5+g2kYCL4Dig5Ohu9gL3dSYW0bzG9MvXKziPpUJC6oREo4YReZ8V5iZ7YmkTu0IL2SNGXmf8fFhfpRNe1DcjWjXvpnmeiolN2gOOegQ3pbZYa74OEeQJz2oFHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772034654; c=relaxed/simple;
	bh=qc6prcWqzeFRwzidx3Y8XuGVhOnMYJ0lw++tQ5s0Mqc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bGYKJInWM9w49ji10TUU4mcpXKzWrTgc898efUjAh1fQLj0W4d/dmy3zGonjU+04a/hPPcqi6k2152JYBBrmloH924qnetc+YIh/sL6ZK78iA5wxTld3a6NY/V8LWov4k5RCk/N+PZoGrEFiQzuX7fklvBDTKRrSUrJYtlcZUXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=uI0mTbOF; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="uI0mTbOF"
Received: from ideasonboard.com (unknown [IPv6:2a00:6020:448c:6c00:cd05:b041:1dc3:f62c])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 27981448;
	Wed, 25 Feb 2026 16:49:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1772034593;
	bh=qc6prcWqzeFRwzidx3Y8XuGVhOnMYJ0lw++tQ5s0Mqc=;
	h=From:Subject:Date:To:Cc:From;
	b=uI0mTbOFxYzo0Q99SS5iQjmuGeqYRZiL08XKauE+ubKxYP7M7SQ5Brwv3jIGeHDa6
	 1JIhbP4aC4pevh9iuYf2wIS0UVMBxQRR4ON5w/8Kxrkez9JXgm3zYGAi8+lu/UzAn9
	 wEJf8yMeOp8gVTq/4HSu4rFHOiUwlX0rK3F2o9ZI=
From: Stefan Klug <stefan.klug@ideasonboard.com>
Subject: [PATCH v4 0/4] media: dw100: Dynamic vertex map updates and fixes
 for PREEMPT_RT
Date: Wed, 25 Feb 2026 16:50:46 +0100
Message-Id: <20260225-sklug-v6-16-topic-dw100-v3-1-dev-v4-0-53536d08de91@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFYan2kC/5XNsQ7CIBSF4VdpmL2GSwu2Tr6HcaDl0hK1GFDUm
 L676OSgSR3/M3znwSIFR5GtiwcLlFx0fsxRLQrWDXrsCZzJzQQXiiOXEPeHSw9JASo4+5PrwFy
 Rc0glIBhK0NZSKbkyrWoky8wpkHW398V2l3tw8ezD/f2Y8LX+gScEDkpqW1aGV9bUG2dIRz+2X
 gez7PyRvT6S+HCFmOGK7JJGEo3FurP4wy0/3WaGW2ZXUCtVLUlb3nxxp2l6Ap1DNziHAQAA
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

 drivers/media/platform/nxp/dw100/dw100.c | 132 +++++++++++++++++++++----------
 1 file changed, 89 insertions(+), 43 deletions(-)
---
base-commit: 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
change-id: 20260105-sklug-v6-16-topic-dw100-v3-1-dev-b856657db695

Best regards,
-- 
Stefan Klug <stefan.klug@ideasonboard.com>

